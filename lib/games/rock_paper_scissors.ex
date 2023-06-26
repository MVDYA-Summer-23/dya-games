defmodule Games.RockPaperScissors do
  def play do
    IO.puts("Let's play Rock, Paper, Scissors!")
    choice = IO.gets("Choose rock, paper, or scissors: ") |> String.trim()
    computer_choice = Enum.random(["rock", "paper", "scissors"])
    check_choice(choice, computer_choice)
  end

  defp check_choice(choice, computer_choice) do
    if choice === computer_choice do
      IO.puts("It's a tie!")
    else
      case choice do
        "rock" ->
          if computer_choice === "paper" do
            IO.puts("You lose! paper beats rock.")
          else
            IO.puts("You win! rock beats scissors.")
          end

        "paper" ->
          if computer_choice === "scissors" do
            IO.puts("You lose! scissors beats paper.")
          else
            IO.puts("You win! paper beats rock.")
          end

        "scissors" ->
          if computer_choice === "rock" do
            IO.puts("You lose! rock beats scissors.")
          else
            IO.puts("You win! scissors beats paper")
          end
      end
    end
  end
end
