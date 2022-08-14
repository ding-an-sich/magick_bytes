# MagickBytes

A tiny library for inferring MIME types from magic bytes 

## Installation

The package can be installed
by adding `magick_bytes` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:magick_bytes, "~> 0.1.0"}
  ]
end
```

## Usage

To guess the MIME type of a file, just pass its
path as an argument to the mime/1 fn. MagickBytes
will open the file, read from it and try to
guess the MIME type:

```elixir
MagickBytes.mime("/path/to/my/document.pdf")
> {:ok, "application/pdf"}
```

## Security considerations

Remember that every magic is illusion and can be trivially spoofed. In other words, never do anything like this:

```elixir
case MagickBytes.mime(secret_file) do
  {:ok, "application/secret_file"} -> give_password()
  _ -> unauthorized()
end
```
