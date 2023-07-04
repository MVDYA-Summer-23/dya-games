defmodule Games do
  @wordle "Wordle"
  @guess_number "Guess a Number"
  @paper_rock_scissors "Paper, Rock, Scissors"

  def wordle, do: @wordle
  def guess_number, do: @guess_number
  def paper_rock_scissors, do: @paper_rock_scissors

  @spec start :: :ok
  @doc "Automatically start the Games CLI"
  def start do
    GamesCLI.start()
  end
end
