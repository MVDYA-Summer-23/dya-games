defmodule GamesCLI.Wordle do
  alias Owl.Data
  alias Games.Wordle
  alias GamesCLI.UI

  @colors GamesCLI.UI.Colors.values().foreground

  # This is the only game title scenario that doesn't break the bounding box while still centering
  @wordle_letters [
    Data.tag("W ", [@colors.green, :bright]),
    Data.tag("O ", [@colors.yellow, :bright]),
    Data.tag("R ", [@colors.red, :bright]),
    Data.tag("D ", [@colors.green, :bright]),
    Data.tag("L ", [@colors.yellow, :bright]),
    Data.tag("E", [@colors.red, :bright])
  ]

  @game_header_text Enum.concat([["***   "], @wordle_letters, ["   ***"]])

  @game_rules %{
    header: "Rules",
    description: [
      """
      Try to guess a random 6-letter English word in six tries!
      For each guess, you'll see colored feedback for each letter:\n
      """,
      "* ",
      Data.tag("green", :green),
      ": you guessed correctly\n",
      "* ",
      Data.tag("yellow", :yellow),
      ": the letter is in the word, but in the wrong place\n",
      "* ",
      Data.tag("red", :red),
      ": the letter is not in the word."
    ]
  }

  def start() do
    UI.show_game_header(@game_header_text)
    UI.show_game_rules(@game_rules)
    play()
  end

  def play(rounds \\ 6) do
    answer = Wordle.get_answer()
    IO.inspect(answer, label: "Answer")
    guess = get_guess(rounds)
    play(answer, guess, rounds)
  end

  def play(answer, _guess, 0) do
    Owl.IO.puts("\nYou lose! The answer was #{answer}")
    replay_game?()
  end

  def play(answer, guess, rounds) do
    case Wordle.get_feedback(answer, guess) do
      [:green, :green, :green, :green, :green] = feedback ->
        show_guess(answer, guess, feedback)
        Owl.IO.puts("\nYou win!")
        replay_game?()

      feedback ->
        rounds_left = rounds - 1
        show_guess(answer, guess, feedback)
        next_guess = if rounds_left !== 0, do: get_guess(rounds_left), else: nil
        play(answer, next_guess, rounds_left)
    end
  end

  defp get_guess(rounds) do
    guess = Owl.IO.input(label: "")

    if String.length(guess) !== 5 do
      Owl.IO.puts("That's not five letters. Try again.")
      get_guess(rounds)
    else
      guess
    end
  end

  defp replay_game?(), do: UI.play_again?(fn -> __MODULE__.play() end)

  defp show_guess(_target, guess, feedback) do
    guess_list = String.graphemes(guess) |> Enum.map(&String.upcase/1)

    response =
      Enum.zip(guess_list, feedback)
      |> GamesCLI.UI.style_letter_list(block: true, bold: true)

    Owl.IO.puts("#{response}")
  end
end
