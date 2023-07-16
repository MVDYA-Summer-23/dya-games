defmodule Games.GuessingGame do
  @game_info %{
    numbers: %{
      header: "GUESS A NUMBER",
      rules: %{
        header: "Rules",
        description: ["Try to guess a random number between 1 and 10"]
      }
    },
    words: %{
      header: "GUESS A WORD",
      rules: %{
        header: "Rules",
        description: ["Try to guess a word that matches its hint"]
      }
    }
  }

  @words [
    {"dog", "housepet"},
    {"carrot", "usually orange veggie"},
    {"ball", "sphere used for exercise and games"}
  ]

  @numbers 1..10

  @moduledoc """
  Guessing game logic with games using numbers or words
  """

  def get_game_info(game) do
    @game_info[game]
  end

  def setup_game(:words) do
    {answer, hint} = Enum.random(@words)

    player_hint =
      "Okay, so the word has #{String.length(answer)} letters and the hint is: #{hint}"

    {answer, player_hint}
  end

  def setup_game(:numbers) do
    answer = Enum.random(@numbers) |> to_string()
    {answer, nil}
  end

  def get_game_over_message(result, variables \\ %{}) do
    case result do
      :win -> "You win!"
      :lose -> "You lose! The answer was #{variables.answer}"
    end
  end
end
