defmodule MagickBytes.CustomMatcherTest do
  use ExUnit.Case, async: true

  defmodule SimpleMatcher do
    use MagickBytes.CustomMatcher,
      signature: <<23, 23>>,
      mime: "application/custom-match"
  end

  defmodule StringMatcher do
    use MagickBytes.CustomMatcher,
      signature: <<23, 23>>,
      string: "hello",
      mime: "application/custom-match"
  end

  defmodule AnyMatcher do
    use MagickBytes.CustomMatcher, mime: "application/custom-match"
  end

  test "should match <<match>>" do
    assert SimpleMatcher.mime(<<23, 23>>) == "application/custom-match"
    refute SimpleMatcher.mime(<<23, 24>>)
  end

  test "should match <<match>> and <<string>>" do
    assert StringMatcher.mime(<<23, 23, 0, 0, 0, 104, 101, 108, 108, 111>>) ==
             "application/custom-match"

    refute StringMatcher.mime(<<23, 23, 0, 1, 0, 105, 101, 107, 108, 111>>)
  end

  test "should match anything" do
    assert AnyMatcher.mime(<<23, 23>>) == "application/custom-match"
  end
end
