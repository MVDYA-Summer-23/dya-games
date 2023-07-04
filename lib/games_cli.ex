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
