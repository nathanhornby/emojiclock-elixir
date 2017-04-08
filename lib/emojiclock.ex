defmodule EmojiClock do
  @moduledoc """
  Returns a clock emoji for a given hour.
  """

  @doc ~S"""
  Returns a clock emoji for the `local` hour. Accepts an optional `integer` offset.

  ## Examples

      iex> # If it's 18:37 you'll get "🕕"
      iex> clock = EmojiClock.now!
      iex> is_bitstring(clock)
      true
  """
  @spec now!(integer) :: String.t
  def now!(offset \\ 0) do
    formated_time = format_time(Timex.local)
    hour_with_offset = formated_time + offset
    emoji(hour_with_offset)
  end

  @doc ~S"""
  Returns a clock emoji for the `local` hour. Accepts an optional `integer` offset.

  ## Examples

      iex> # If it's 18:37 you'll get {:ok, "🕕"}
      iex> {:ok, clock} = EmojiClock.now
      iex> is_bitstring(clock)
      true

      iex> # If it's 18:37 you'll get {:ok, "🕓"}
      iex> {:ok, clock} = EmojiClock.now(-2)
      iex> is_bitstring(clock)
      true

  Invalid input returns an error:

      iex> EmojiClock.now("+8")
      {:error, :invalid_argument}
  """
  @spec now(integer) :: {atom, String.t}
  def now(offset \\ 0)
  def now(offset) when is_integer(offset) do
    formated_time = format_time(Timex.local)
    hour_with_offset = formated_time + offset
    {:ok, emoji(hour_with_offset)}
  end

  @spec now(term) :: {atom, atom}
  def now(_input), do: {:error, :invalid_argument}

  @doc ~S"""
  Returns a clock emoji for a given `integer` hour between 0 and 12.

  ## Examples

      iex> EmojiClock.hour!(6)
      "🕕"

      iex> EmojiClock.hour!(12)
      "🕛"
  """
  @spec hour!(non_neg_integer) :: String.t
  def hour!(hour) when is_integer(hour) and hour >= 1 and hour <= 12 do
    emoji(hour)
  end

  @doc ~S"""
  Returns a clock emoji for a given `integer` hour between 0 and 12.

  ## Examples

      iex> EmojiClock.hour(6)
      {:ok, "🕕"}

      iex> EmojiClock.hour(12)
      {:ok, "🕛"}

  Invalid input returns an error:

      iex> EmojiClock.hour("2")
      {:error, :invalid_argument}

      iex> EmojiClock.hour(16)
      {:error, :invalid_argument}
  """
  @spec hour(non_neg_integer) :: {atom, String.t}
  def hour(hour) when is_integer(hour) and hour >= 1 and hour <= 12 do
    {:ok, emoji(hour)}
  end
  @spec hour(term) :: {atom, atom}
  def hour(_input), do: {:error, :invalid_argument}

  @doc ~S"""
  Returns a clock emoji for a given UNIX timestamp `integer`.

  ## Examples

      iex> EmojiClock.unix!(475359803)
      "🕗"

      iex> EmojiClock.unix!(1491517308)
      "🕙"

  """
  @spec unix!(pos_integer) :: String.t
  def unix!(timestamp) when is_integer(timestamp) do
    do_unix(timestamp)
  end

  @doc ~S"""
  Returns a clock emoji for a given UNIX timestamp `integer`.

  ## Examples

      iex> EmojiClock.unix(475359803)
      {:ok, "🕗"}

      iex> EmojiClock.unix(1491517308)
      {:ok, "🕙"}

  Invalid input returns an error:

      iex> EmojiClock.unix("4753598030")
      {:error, :invalid_type}

      iex> EmojiClock.unix("clock pls")
      {:error, :invalid_type}
  """
  @spec unix(pos_integer) :: {atom, String.t}
  def unix(timestamp) when is_integer(timestamp) do
    {:ok, do_unix(timestamp)}
  end

  @spec unix(term) :: {atom, atom}
  def unix(_input), do: {:error, :invalid_type}

  @doc ~S"""
  Returns a clock emoji for a given ISO datetime `bitsring`.

  ## Examples

      iex> EmojiClock.iso!("2017-04-06T20:32:16+00:00")
      "🕗"

      iex> EmojiClock.iso!("1985-01-23T22:07:54Z")
      "🕙"
  """
  @spec iso!(String.t) :: String.t
  def iso!(datetime) when is_bitstring(datetime) do
    do_iso(datetime)
  end

  @doc ~S"""
  Returns a clock emoji for a given ISO datetime `bitsring`.

  ## Examples

      iex> EmojiClock.iso!("2017-04-06T20:32:16+00:00")
      "🕗"

      iex> EmojiClock.iso!("1985-01-23T22:07:54Z")
      "🕙"

  Invalid input returns an error:

      iex> EmojiClock.iso(49)
      {:error, :invalid_type}

      iex> EmojiClock.iso(~N[2000-01-01 04:00:07.000000])
      {:error, :invalid_type}
  """
  @spec iso(String.t) :: {atom, String.t}
  def iso(datetime) when is_bitstring(datetime) do
    {:ok, do_iso(datetime)}
  end

  @spec iso(term) :: {atom, atom}
  def iso(_input), do: {:error, :invalid_type}

  @doc ~S"""
  Returns a clock emoji for a given Elixir `NaiveDateTime` struct.

  ## Examples

      iex> EmojiClock.naive!(~N[2000-01-01 04:00:07.000000])
      "🕓"

      iex> EmojiClock.naive!(~N[1985-01-23 20:30:42.657002])
      "🕗"
  """
  @spec naive!(struct) :: String.t
  def naive!(datetime) when is_map(datetime) do
    do_elixir_native_format(datetime)
  end

  @doc ~S"""
  Returns a clock emoji for a given Elixir `NaiveDateTime` struct.

  ## Examples

      iex> EmojiClock.naive(~N[2000-01-01 04:00:07.000000])
      {:ok, "🕓"}

      iex> EmojiClock.naive(~N[1985-01-23 20:30:42.657002])
      {:ok, "🕗"}

  Invalid input returns an error:

      iex> EmojiClock.naive(49)
      {:error, :invalid_type}

      iex> EmojiClock.naive("clock pls")
      {:error, :invalid_type}
  """
  @spec naive(struct) :: {atom, String.t}
  def naive(datetime) when is_map(datetime) do
    {:ok, do_elixir_native_format(datetime)}
  end

  @spec naive(term) :: {atom, atom}
  def naive(_input), do: {:error, :invalid_type}

  @doc ~S"""
  Returns a clock emoji for a given Elixir `Time` struct.

  ## Examples

      iex> EmojiClock.time!(~T[14:32:07.052])
      "🕑"

      iex> EmojiClock.time!(~T[08:21:42])
      "🕗"
  """
  @spec time!(struct) :: String.t
  def time!(time) do
    do_elixir_native_format(time)
  end

  @doc ~S"""
  Returns a clock emoji for a given Elixir `Time` struct.

  ## Examples

      iex> EmojiClock.time(~T[14:32:07.052])
      {:ok, "🕑"}

      iex> EmojiClock.time(~T[08:21:42])
      {:ok, "🕗"}

  Invalid input returns an error:

      iex> EmojiClock.time(49)
      {:error, :invalid_type}

      iex> EmojiClock.time("clock pls")
      {:error, :invalid_type}
  """
  @spec time(struct) :: {atom, String.t}
  def time(time) when is_map(time) do
    {:ok, do_elixir_native_format(time)}
  end

  @spec time(term) :: {atom, atom}
  def time(_input), do: {:error, :invalid_type}

  @doc ~S"""
  Returns a clock emoji for a given Elixir `DateTime` struct.

  ## Examples

      iex> datetime = %DateTime{
      ...>              calendar: Calendar.ISO,
      ...>              day: 7,
      ...>              hour: 15,
      ...>              microsecond: {817699, 6},
      ...>              minute: 5,
      ...>              month: 4,
      ...>              second: 43,
      ...>              std_offset: 0,
      ...>              time_zone: "Etc/UTC",
      ...>              utc_offset: 0,
      ...>              year: 2017,
      ...>              zone_abbr: "UTC"}
      iex> EmojiClock.datetime!(datetime)
      "🕒"

      iex> datetime = %DateTime{
      ...>              calendar: Calendar.ISO,
      ...>              day: 3,
      ...>              hour: 8,
      ...>              microsecond: {000000, 6},
      ...>              minute: 42,
      ...>              month: 1,
      ...>              second: 23,
      ...>              std_offset: 0,
      ...>              time_zone: "Etc/UTC",
      ...>              utc_offset: 0,
      ...>              year: 1985,
      ...>              zone_abbr: "UTC"}
      iex> EmojiClock.datetime!(datetime)
      "🕗"
  """
  @spec datetime!(struct) :: String.t
  def datetime!(datetime) do
    do_elixir_native_format(datetime)
  end

  @doc ~S"""
  Returns a clock emoji for a given Elixir `DateTime` struct.

  ## Examples

      iex> datetime = %DateTime{
      ...>              calendar: Calendar.ISO,
      ...>              day: 7,
      ...>              hour: 15,
      ...>              microsecond: {817699, 6},
      ...>              minute: 5,
      ...>              month: 4,
      ...>              second: 43,
      ...>              std_offset: 0,
      ...>              time_zone: "Etc/UTC",
      ...>              utc_offset: 0,
      ...>              year: 2017,
      ...>              zone_abbr: "UTC"}
      iex> EmojiClock.datetime(datetime)
      {:ok, "🕒"}

      iex> datetime = %DateTime{
      ...>              calendar: Calendar.ISO,
      ...>              day: 3,
      ...>              hour: 8,
      ...>              microsecond: {000000, 6},
      ...>              minute: 42,
      ...>              month: 1,
      ...>              second: 23,
      ...>              std_offset: 0,
      ...>              time_zone: "Etc/UTC",
      ...>              utc_offset: 0,
      ...>              year: 1985,
      ...>              zone_abbr: "UTC"}
      iex> EmojiClock.datetime(datetime)
      {:ok, "🕗"}

  Invalid input returns an error:

      iex> EmojiClock.datetime(49)
      {:error, :invalid_type}

      iex> EmojiClock.datetime("clock pls")
      {:error, :invalid_type}
  """
  @spec datetime(struct) :: {atom, String.t}
  def datetime(datetime) when is_map(datetime) do
    {:ok, do_elixir_native_format(datetime)}
  end

  @spec datetime(term) :: {atom, atom}
  def datetime(_input), do: {:error, :invalid_type}

  # Private functions

  defp do_unix(timestamp) do
    timestamp
    |> Timex.from_unix
    |> format_time
    |> emoji
  end

  defp do_iso(datetime) do
    datetime
    |> Timex.parse!("{ISO:Extended}")
    |> format_time
    |> emoji
  end

  defp do_elixir_native_format(datetime) do
    datetime
    |> format_time
    |> emoji
  end

  defp format_time(input) do
    input
    |> Timex.format!("{h12}")
    |> String.to_integer
  end

  defp emoji(hour) do
    clocks = %{
               0 => "🕛",
               1 => "🕐",
               2 => "🕑",
               3 => "🕒",
               4 => "🕓",
               5 => "🕔",
               6 => "🕕",
               7 => "🕖",
               8 => "🕗",
               9 => "🕘",
              10 => "🕙",
              11 => "🕚",
              12 => "🕛"
            }
    Map.get(clocks, hour)
  end
end
