defmodule RockPaperScissorsTest do
  use ExUnit.Case
  alias Games.RockPaperScissors

  test "Tie" do
    assert RockPaperScissors.check_choice("rock", "rock") === "It's a tie!"
  end

  test "Rock wins" do
    assert RockPaperScissors.check_choice("rock", "scissors") === "You win! rock beats scissors."
  end

  test "Paper loses" do
    assert RockPaperScissors.check_choice("paper", "scissors") ===
             "You lose! scissors beats paper."
  end

  test "Scissors wins" do
    assert RockPaperScissors.check_choice("scissors", "paper") ===
             "You win! scissors beats paper."
  end
end
