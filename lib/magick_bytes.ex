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

      iex> MagickBytes.mime("./test/fixtures/my_gzip_file_disguised_as.txt")
      {:ok, "application/gzip"}

  """
  @spec mime(path :: Path.t()) :: {:ok, String.t()} | {:error, atom()}
  def mime(path) when is_binary(path) do
    with {:ok, file} <- File.open(path),
         binary <- IO.binread(file, 16),
         :ok <- File.close(file) do
      {:halt, match} = Matcher.match(binary)
      {:ok, match}
    end
  end

  @spec mime!(path :: Path.t()) :: String.t() | no_return()
  def mime!(path) when is_binary(path) do
    file = File.open!(path)
    data = IO.binread(file, 16)

    File.close(file)

    {:halt, match} = Matcher.match(data)
    match
  end
end
