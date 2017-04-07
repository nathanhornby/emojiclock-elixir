defmodule EmojiClock.Mixfile do
  use Mix.Project

  def project do
    [app: :emojiclock,
     version: "0.9.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     # Docs:
     name: "🕒 emojiclock",
     source_url: "https://github.com/nathanhornby/emojiclock-elixir"]
  end

  def application do
    [extra_applications: [:logger, :timex]]
  end

  defp deps do
    [{:timex, "~> 3.0"},
     {:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end
end
