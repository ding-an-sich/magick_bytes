defmodule MagickBytes.Matcher do
  # 1F 8B
  def match(<<31, 139>>) do
    {:match, "application/gzip"}
  end

  # FF D8 FF
  def match(<<255, 216, 255>>) do
    {:match, "image/jpeg"}
  end

  # ED AB EE DB
  def match(<<237, 171, 238, 219>>) do
    {:match, "application/x-rpm"}
  end

  # 4F 67 67 53
  def match(<<79, 103, 103, 83>>) do
    {:match, "application/ogg"}
  end

  # 25 50 44 46 2D
  def match(<<37, 80, 68, 70, 45>>) do
    {:match, "application/pdf"}
  end

  # 52 49 46 46
  # ?? ?? ?? ??
  # 41 56 49 20
  def match(<<82, 73, 70, 70, _::8, _::8, _::8, _::8, 65, 86, 73, 32>>) do
    {:match, "audio/x-avi"}
  end

  # 52 49 46 46
  # ?? ?? ?? ??
  # 57 41 56 45
  def match(<<82, 73, 70, 70, _::8, _::8, _::8, _::8, 87, 65, 86, 69>>) do
    {:match, "audio/x-wav"}
  end

  # 42 4d ?? ?? ?? ?? ?? ??
  # ?? ?? ?? ?? 00 00 ?? 00
  # http://fileformats.archiveteam.org/wiki/BMP#Identifiers
  def match(<<66, 77, _::8, _::8, _::8, _::8, _::8, _::8, _::8, _::8, _::8, 0, 0, _::8, 0>>) do
    {:match, "application/x-ms-bmp"}
  end

  # 53 51 4C 69 74 65 20 66
  # 6F 72 6D 61 74 20 33 00
  def match(<<83, 81, 76, 105, 116, 101, 32, 102, 111, 114, 109, 97, 116, 32, 51, 0>>) do
    {:match, "application/vnd.sqlite3"}
  end

  # 1A 45 DF A3
  def match(<<26, 69, 223, 163, rest::binary>> = bytes) do
    cond do
      pattern_match(rest, <<119, 101, 98, 109>>) ->
        {:match, "video/webm"}

      pattern_match(rest, <<109, 97, 116, 114, 111, 115, 107, 97>>) ->
        {:match, "video/matroska"}

      true ->
        {:continue, :no_match, bytes}
    end
  end

  def match(bytes) do
    {:continue, :no_match, bytes}
  end

  defp pattern_match(binary, pattern) do
    case :binary.match(binary, pattern) do
      :nomatch -> false
      _ -> true
    end
  end
end
