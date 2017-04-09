defmodule EmojiClock.Mixfile do
  use Mix.Project

  @version "2.0.1"

  def project do
    [app: :emojiclock,
     version: @version,
     description: description(),
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps(),
     # ExDoc:
     name: "🕒 EmojiClock",
     source_url: "https://github.com/nathanhornby/emojiclock-elixir",
     docs: [
       source_ref: "v#{@version}",
       main: "readme",
       extras: ["README.md"]
       ]
     ]
  end

  def application do
    [extra_applications: [:logger, :timex]]
  end

  defp description do
    """
    🕒 An Elixir module for giving you an emoji clock for a given hour.
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
     {:ex_doc, "~> 0.14", only: :dev, runtime: false},
     {:credo, "~> 0.7", only: [:dev, :test]}]
  end
end
