defmodule MagickBytes.CustomMatcherTest do
  use ExUnit.Case, async: true

  defmodule SimpleMatcher do
    use MagickBytes.CustomMatcher, signature: <<23, 23>>
  end

  defmodule StringMatcher do
    use MagickBytes.CustomMatcher, signature: <<23, 23>>, string: "hello"
  end

  test "should match <<match>>" do
    assert SimpleMatcher.match?(<<23, 23>>)
    refute SimpleMatcher.match?(<<23, 24>>)
  end

  test "should match <<match>> and <<string>>" do
    assert StringMatcher.match?(<<23, 23, 0, 0, 0, 104, 101, 108, 108, 111>>)
    refute StringMatcher.match?(<<23, 23, 0, 1, 0, 105, 101, 107, 108, 111>>)
  end
end
