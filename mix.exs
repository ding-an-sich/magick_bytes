defmodule MagickBytes.MixProject do
  use Mix.Project

  @description "A tiny library for inferring MIME types from magic bytes"

  def project do
    [
      app: :magick_bytes,
      version: "0.1.0",
      elixir: "~> 1.13",
      description: @description,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: ["lib"],
      maintainers: ["Vinicius Moraes"],
      licenses: ["Apache-2.0"],
      links: %{"Github" => "https://github.com/ding-an-sich/magick_bytes"}
    ]
  end

  defp deps do
    [
      {:stream_data, "~> 0.5", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
