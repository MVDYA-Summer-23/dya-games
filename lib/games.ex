defmodule Games do
  @main_title "ARCADE MADNESS"

  @wordle "Wordle"
  @guess_number "Guess a Number"
  @guess_word "Guess a Word"
  @paper_rock_scissors "Paper, Rock, Scissors"

  def main_title, do: @main_title

  def wordle, do: @wordle
  def guess_number, do: @guess_number
  def guess_word, do: @guess_word
  def paper_rock_scissors, do: @paper_rock_scissors

  @spec start :: :ok
  @doc "Automatically start the Games CLI"
  def start do
    GamesCLI.start()
  end
end
