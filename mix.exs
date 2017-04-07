defmodule EmojiClock.Mixfile do
  use Mix.Project

  def project do
    [app: :emojiclock,
     version: "1.0.0",
     description: description(),
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps(),
     # Docs:
     name: "🕒 emojiclock",
     source_url: "https://github.com/nathanhornby/emojiclock-elixir"]
  end

  def application do
    [extra_applications: [:logger, :timex]]
  end

  defp description do
    """
    An Elixir module for giving you an emoji clock for a specific hour.
    """
  end

  defp package do
    [maintainers: ["Nathan Hornby"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/nathanhornby/emojiclock-elixir",
              "Docs"   => "https://hexdocs.pm/emojiclock"}]
  end

  defp deps do
    [{:timex, "~> 3.0"},
     {:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end
end
