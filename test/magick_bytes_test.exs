defmodule MagickBytesTest do
  use ExUnit.Case, async: true
  doctest MagickBytes

  describe "mime/1" do
    test "should match zip" do
      assert {:ok, "application/zip"} == MagickBytes.mime("./test/archives/zipfile.zip")
    end

    test "should match matroska" do
      assert {:ok, "video/x-matroska"} ==
               MagickBytes.mime("./test/archives/test1.mkv")
    end

    test "should match webm" do
      assert {:ok, "video/webm"} ==
               MagickBytes.mime("./test/archives/big-buck-bunny_trailer.webm")
    end

    test ~s|should return {:error, :no_match} after reading an empty file
    and failing to find a match| do
      assert {:error, :no_match} == MagickBytes.mime("./test/archives/empty")
    end
  end
end
