defmodule Games do
  @available_games ["guess a random number or word", "paper, rock, scissors", "wordle"]

  @moduledoc """
  Welcome to the Games collection
  """
  @doc "Show which games are available to play"
  @spec play() :: [any()]
  def play do
    IO.puts("Welcome\nChoose a game...")

    Enum.with_index(@available_games, fn game, index ->
      IO.puts("   #{index + 1}: #{game}")
    end)
  end
end
