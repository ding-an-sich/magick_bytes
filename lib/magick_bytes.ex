defmodule MagickBytes do
  @moduledoc """
  A tiny library for inferring
  MIME types from magic bytes.
  """

  alias MagickBytes.Matcher

  @doc """
  Tries to infer the MIME type
  of the file at `path` from
  its magic bytes.

  ## Examples

      iex> MagickBytes.mime("./test/archives/my_gzip_file_disguised_as.txt")
      {:ok, "application/gzip"}

  """
  @spec mime(path :: Path.t()) :: {:ok, String.t()} | {:error, atom()}
  def mime(path) when is_binary(path) do
    with {:ok, file} <- File.open(path, [{:read_ahead, 640}]),
         result <- try_match(file),
         :ok <- File.close(file) do
      result
    end
  end

  defp try_match(file) do
    with {:ok, byte} <- :file.pread(file, 0, 1),
         {:continue, :no_match, _bytes} <- Matcher.match(byte) do
      try_match(file, 1, byte)
    else
      :eof -> {:error, :no_match}
      {:error, :einval} -> {:error, :no_match}
      {:match, match} -> {:ok, match}
    end
  end

  defp try_match(_file, 640, _bytes), do: {:error, :no_match}

  defp try_match(file, current_offset, bytes_read) do
    with {:ok, byte} <- :file.pread(file, current_offset, 1),
         {:continue, :no_match, bytes} <-
           Matcher.match(<<bytes_read::binary>> <> <<byte::binary>>) do
      try_match(file, current_offset + 1, bytes)
    else
      :eof -> {:error, :no_match}
      {:error, :einval} -> {:error, :no_match}
      {:match, match} -> {:ok, match}
      error -> error
    end
  end
end
