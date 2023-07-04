defmodule GamesCLI.Wordle do
  alias Owl.{Box, Data}
  alias Games.Wordle

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

  def start() do
    show_game_header()
    show_game_rules()
    play()
  end

  def show_game_header() do
    Box.new(@game_header_text,
      border_style: :double,
      min_width: 70,
      horizontal_align: :center,
      padding_y: 1,
      border_tag: :cyan
    )
    |> Owl.IO.puts()
  end

  def show_game_rules(word_length \\ 5) do
    [
      Box.new("Rules",
        padding_bottom: 1,
        min_width: 64,
        border_style: :none,
        horizontal_align: :center
      ),
      Box.new(
        [
          """
          Try to guess a random #{word_length}-letter English word in six tries!
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
        ],
        min_width: 64,
        border_style: :none
      )
    ]
    |> Box.new(max_width: 70, padding_x: 2, padding_y: 1)
    |> Owl.IO.puts()
  end

  def play(rounds \\ 6) do
    target = Wordle.get_answer()
    guess = get_guess(rounds)
    play(target, guess, rounds)
  end

  defp play(target, _guess, 0) do
    Owl.IO.puts("\nYou lose! The answer was #{target}")
    play_again?()
  end

  defp play(target, guess, rounds) do
    case Wordle.get_feedback(target, guess) do
      [:green, :green, :green, :green, :green] = feedback ->
        show_guess(target, guess, feedback)
        Owl.IO.puts("\nYou win!")
        play_again?()

      feedback ->
        rounds_left = rounds - 1
        show_guess(target, guess, feedback)
        next_guess = if rounds_left !== 0, do: get_guess(rounds_left), else: nil
        play(target, next_guess, rounds_left)
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

  defp show_guess(_target, guess, feedback) do
    guess_list = String.graphemes(guess) |> Enum.map(&String.upcase/1)

    response =
      Enum.zip(guess_list, feedback)
      |> GamesCLI.UI.style_letter_list(block: true, bold: true)

    Owl.IO.puts("#{response}")
  end

  defp play_again?() do
    again = Owl.IO.confirm(message: Data.tag("Play again?", @colors.yellow), default: true)

    case again do
      true ->
        start()

      false ->
        Games.start()
    end
  end
end
