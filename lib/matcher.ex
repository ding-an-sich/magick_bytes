defmodule MagickBytes.Matcher do
  # 53 51 4C 69 74 65 20 66
  # 6F 72 6D 61 74 20 33 00
  def match(
        <<83, 81, 76, 105, 116, 101, 32, 102, 111, 114, 109, 97, 116, 32, 51, 0, _rest::binary>>
      ) do
    {:halt, "application/vnd.sqlite3"}
  end

  # 42 4d ?? ?? ?? ?? ?? ??
  # ?? ?? ?? ?? 00 00 ?? 00
  # http://fileformats.archiveteam.org/wiki/BMP#Identifiers
  def match(
        <<66, 77, _::8, _::8, _::8, _::8, _::8, _::8, _::8, _::8, _::8, 0, 0, _::8, 0,
          _rest::binary>>
      ) do
    {:halt, "application/x-ms-bmp"}
  end

  # 52 49 46 46
  # ?? ?? ?? ??
  # 57 41 56 45
  def match(<<82, 73, 70, 70, _::8, _::8, _::8, _::8, 87, 65, 86, 69, _rest::binary>>) do
    {:halt, "audio/x-wav"}
  end

  # 52 49 46 46
  # ?? ?? ?? ??
  # 41 56 49 20
  def match(<<82, 73, 70, 70, _::8, _::8, _::8, _::8, 65, 86, 73, 32, _rest::binary>>) do
    {:halt, "audio/x-avi"}
  end

  # 25 50 44 46 2D
  def match(<<37, 80, 68, 70, 45, _rest::binary>>) do
    {:halt, "application/pdf"}
  end

  # 4F 67 67 53
  def match(<<79, 103, 103, 83, _rest::binary>>) do
    {:halt, "application/ogg"}
  end

  # ED AB EE DB
  def match(<<237, 171, 238, 219, _rest::binary>>) do
    {:halt, "application/x-rpm"}
  end

  # FF D8 FF
  def match(<<255, 216, 255, _rest::binary>>) do
    {:halt, "image/jpeg"}
  end

  # 1F 8B
  def match(<<31, 139, _rest::binary>>) do
    {:halt, "application/gzip"}
  end
end
