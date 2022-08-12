defmodule MagickBytes.CustomMatcher do
  defmacro __using__(opts) do
    match = Keyword.fetch!(opts, :signature)
    bin = Keyword.get(opts, :string, nil)

    quote do
      def match?(bytes_to_match) do
        signature(bytes_to_match) && string(bytes_to_match)
      end

      defp signature(<<unquote(match), _rest::binary>>), do: true
      defp signature(_), do: false

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
