defmodule GamesCLI.GuessingGame do
  alias Games.GuessingGame
  alias GamesCLI.UI

  def start_game(game) do
    %{header: header, rules: rules} = GuessingGame.get_game_info(game)
    UI.show_game_header(header)
    UI.show_game_rules(rules)
    play_game(game)
  end

  def play_game(game) do
    {answer, player_hint} = GuessingGame.setup_game(game)
    if player_hint, do: IO.puts(player_hint)
    IO.inspect(answer, label: "Answer")
    play_round(game, answer, 5)
  end

  def play_round(game, answer, 0) do
    lose_message = GuessingGame.get_game_over_message(:lose, %{answer: answer})
    IO.puts(lose_message)
    replay_game?(game)
  end

  def play_round(game, answer, rounds) do
    case UI.get_guess("Your guess: ") do
      ^answer ->
        GuessingGame.get_game_over_message(:win)
        |> IO.puts()

        replay_game?(game)

      _ ->
        play_round(game, answer, rounds - 1)
    end
  end

  defp replay_game?(game), do: UI.play_again?(fn -> __MODULE__.play_game(game) end)
end
