defmodule Games.GuessingGame do
  @words [
    {"dog", "housepet"},
    {"carrot", "usually orange veggie"},
    {"ball", "sphere used for exercise and games"}
  ]

  @numbers 1..10

  defp string_to_int(string), do: String.trim(string) |> String.to_integer()

  def play() do
    answer = Enum.random(@numbers)
    guess = IO.gets("Guess a number between 1 and 10: ") |> string_to_int()
    check_guess(answer, guess)
  end

  def play_words() do
    IO.puts("Let's play a word guessing game. Are you ready?")
    ready = IO.gets("y/n: ") |> String.trim()

    if ready === "y" do
      {answer, hint} = Enum.random(@words)
      IO.puts("Okay, so the word has #{String.length(answer)} letters and the hint is: #{hint}")
      guess = IO.gets("Enter your guess: ") |> String.trim()
      check_guess(answer, guess)
    else
      IO.puts("Okay...come back when ready")
    end
  end

  def check_guess(answer, guess, chances \\ 4) do
    if answer === guess do
      IO.puts("Correct!")
    else
      IO.puts("Incorrect.")

      if chances > 0 do
        if Enum.all?([answer, guess], &is_integer(&1)) do
          (answer > guess && "Too Low!") ||
            "Too High!"
            |> IO.puts()
        end
      else
        IO.puts("You lose. The answer was #{answer}")
      end

      new_guess = IO.gets("Enter your guess: ") |> string_to_int()
      check_guess(answer, new_guess, chances - 1)
    end
  end
end
