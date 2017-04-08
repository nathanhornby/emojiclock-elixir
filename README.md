# EmojiClock
[![Elixir](https://img.shields.io/badge/🕒-Elixir-blue.svg)](https://github.com/nathanhornby/emojiclock-elixir)
[![Code Climate](https://codeclimate.com/github/nathanhornby/emojiclock-elixir/badges/gpa.svg)](https://codeclimate.com/github/nathanhornby/emojiclock-elixir) [![Hex.pm](https://img.shields.io/hexpm/v/emojiclock.svg)](https://hex.pm/packages/emojiclock)
[![Hexdocs](https://img.shields.io/badge/docs-hexdocs-blue.svg)](https://hexdocs.pm/emojiclock/readme.html)

An Elixir module for giving you an emoji clock for a given hour. See the [API reference](https://hexdocs.pm/emojiclock/EmojiClock.html) for the many available input formats.

```elixir
iex> EmojiClock.time!(~T[02:17:47.179])
"🕑"
```

## Installing EmojiClock

The package can be installed by adding `emojiclock` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:emojiclock, "~> 1.0.0"}]
end
```

And then added as an extra application, also in `mix.exs`:

```elixir
def application do
  [extra_applications: [:emojiclock]]
end
```

## Using EmojiClock

- [API reference](https://hexdocs.pm/emojiclock/EmojiClock.html)

The `EmojiClock` module has several functions, all of which return an emoji clock `bitstring`. Every function that accepts an argument has a `!` variant, which should be used if you trust your input and want to get straight to the emoji.

```elixir
iex> EmojiClock.unix(475359803)
{:ok, "🕗"}

iex> EmojiClock.unix!(475359803)
"🕗"
```
