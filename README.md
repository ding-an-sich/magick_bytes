# MagickBytes

A tiny library for inferring MIME types from magic bytes 

## Installation

The package can be installed
by adding `magick_bytes` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:magick_bytes, "~> 0.2.0"}
  ]
end
```

## Usage

### Common MIME types

To guess the MIME type of a file, just pass its
path as an argument to the mime/1 fn. MagickBytes
will open the file, read from it and try to
guess the MIME type:

```elixir
MagickBytes.mime("/path/to/my/document.pdf")
> {:ok, "application/pdf"}
```

### Custom matchers

If the file that you are trying to match is not
covered by this library or is otherwise a custom
format, you can set up your own matcher:

```elixir
defmodule ObscureFileMatcher do
  use MagickBytes.CustomMatcher,

    # Matches a byte signature (magic bytes)
    signature: <<1, 2, 3, 4, 5, 6>>,

    # Matches an ASCII string in the file
    string: "EBML",

    # The mime string to be returned if
    # a match is found
    mime: "application/obscure_format"
end
```

You can then pass to your custom matcher
a group of bytes and it will try a match:

```elixir
ObscureFileMatcher.mime(<<1, 2, 3, 4, 5, 6, 69, 66, 77, 76>>)
> "application/obscure_format"

ObscureFileMatcher.mime(<<42, 13, 69>>)
> false
```

All conditions are checked and must pass to return a match.

## Security considerations

Remember that every magic is illusion and can be trivially spoofed. In other words, never do anything like this:

```elixir
case MagickBytes.mime(secret_file) do
  {:ok, "application/secret_file"} -> give_password()
  _ -> unauthorized()
end
```
