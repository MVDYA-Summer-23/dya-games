defmodule GamesCLI do
  alias Games.{PaperRockScissors, GuessingGame}
  alias GamesCLI.Wordle

  # These are generated to provide static, pre-evaluated values since case statements,
  # for example, cannot be used to evaluate values at runtime.
  @guess_number Games.guess_number()
  @wordle Games.wordle()
  @paper_rock_scissors Games.paper_rock_scissors()

  @moduledoc """
  CLI logic
  """

  def colors() do
    %{
      foreground: %{
        white: IO.ANSI.color(15),
        black: IO.ANSI.color(234),
        red: IO.ANSI.color(197),
        yellow: IO.ANSI.color(220),
        green: IO.ANSI.color(46)
      },
      background: %{
        red: IO.ANSI.color_background(197),
        yellow: IO.ANSI.color_background(220),
        green: IO.ANSI.color_background(46)
      }
    }
  end

  @doc """
  Start the CLI
  """
  @spec start :: :ok
  def start() do
    Owl.IO.puts("Welcome to Games")
    Owl.IO.puts("What would you like to play?")

    selection = Owl.IO.select([@guess_number, @wordle, @paper_rock_scissors, "Exit"])

    case selection do
      @guess_number ->
        GuessingGame.play_numbers()

      @wordle ->
        Wordle.play()

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
