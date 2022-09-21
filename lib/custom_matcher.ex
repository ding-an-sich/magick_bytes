defmodule MagickBytes.CustomMatcher do
  defmacro __using__(opts) do
    mime = Keyword.fetch!(opts, :mime)
    match = Keyword.get(opts, :signature, "")
    bin = Keyword.get(opts, :string, nil)

    quote do
      def mime(bytes_to_match) do
        signature(bytes_to_match) && string(bytes_to_match) && unquote(mime)
      end

      defp signature(bytes_to_match) do
        case unquote(match) do
          "" -> true
          any -> match_signature(bytes_to_match)
        end
      end

      defp match_signature(<<unquote(match), _rest::binary>>), do: true
      defp match_signature(_), do: false

      defp string(bytes_to_match) do
        case unquote(bin) do
          nil ->
            true

          string ->
            pattern_match(bytes_to_match, string)
        end
      end

      defp pattern_match(binary, pattern) do
        case :binary.match(binary, pattern) do
          :nomatch -> false
          _ -> true
        end
      end
    end
  end
end
