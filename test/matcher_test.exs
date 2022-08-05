defmodule MagickBytes.MatcherTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  property ~s|match/1 matches or asks for more bytes, returning bytes
      that were matched on previous run| do
    check all bytes <- binary() do
      case MagickBytes.Matcher.match(bytes) do
        {:match, _something} ->
          assert true

        {:continue, :no_match, bytes_matched} ->
          assert bytes_matched == bytes

        _ ->
          raise "should be unreachable"
      end
    end
  end
end
