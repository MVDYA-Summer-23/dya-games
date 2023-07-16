defmodule GamesCLI do
  alias Games.{PaperRockScissors}
  alias GamesCLI.{Wordle, UI, GuessingGame}
  alias Owl.{Data}

  # These are generated to provide static, pre-evaluated values since case statements,
  # for example, cannot be used to evaluate values at runtime.
  @guess_number Games.guess_number()
  @guess_word Games.guess_word()
  @wordle Games.wordle()
  @paper_rock_scissors Games.paper_rock_scissors()

  @colors UI.Colors.values().foreground

  @main_header_letters Data.tag(Games.main_title(), [@colors.green, :bright])
  @main_header_text Enum.concat([["\\*/   "], [@main_header_letters], ["   \\*/"]])

  @moduledoc """
  CLI logic
  """

  @doc "start the Games program in the CLI"
  def start() do
    UI.show_main_header(@main_header_text)
    show_main_menu()
  end

  @doc "Ask the player which game they'd like to play, and load the selected game"
  def show_main_menu() do
    Owl.IO.puts("\nWhat would you like to play?\n")

    selection = Owl.IO.select([@guess_number, @guess_word, @wordle, @paper_rock_scissors, "Exit"])

    case selection do
      @guess_number ->
        GuessingGame.start_game(:numbers)

      @guess_word ->
        GuessingGame.start_game(:words)

      @wordle ->
        Wordle.start()

      @paper_rock_scissors ->
        PaperRockScissors.play()

      "Exit" ->
        Owl.IO.puts("Goodbye!")

      _ ->
        Owl.IO.puts("Invalid input")
        start()
    end
  end
end
