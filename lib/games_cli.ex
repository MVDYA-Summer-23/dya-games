defmodule GamesCLI do
  alias Games.{PaperRockScissors, GuessingGame}
  alias GamesCLI.{Wordle, UI}
  alias Owl.{Data, Box}

  # These are generated to provide static, pre-evaluated values since case statements,
  # for example, cannot be used to evaluate values at runtime.
  @guess_number Games.guess_number()
  @wordle Games.wordle()
  @paper_rock_scissors Games.paper_rock_scissors()

  @colors UI.Colors.values().foreground

  @main_header_letters Data.tag(Games.main_title(), [@colors.green, :bright])
  @main_header_text Enum.concat([["\\*/   "], [@main_header_letters], ["   \\*/"]])

  @moduledoc """
  CLI logic
  """

  def start() do
    show_main_header()
    show_main_menu()
  end

  def show_main_header() do
    IO.puts("")

    Box.new(@main_header_text,
      border_style: :solid_rounded,
      min_width: 70,
      horizontal_align: :center,
      padding_y: 1,
      border_tag: :cyan
    )
    |> Owl.IO.puts()
  end

  def show_main_menu() do
    Owl.IO.puts("\nWhat would you like to play?\n")

    selection = Owl.IO.select([@guess_number, @wordle, @paper_rock_scissors, "Exit"])

    case selection do
      @guess_number ->
        GuessingGame.play_numbers()

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
