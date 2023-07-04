defmodule Games.Wordle do
  @moduledoc """
  Wordle game logic
  """

  @doc """
  Compare two strings using a color scheme for each character, and return an atom list with colors for each corresponding character
  :green matches a character with correct location
  :yellow matches a character with incorrect location
  :red indicates no matching characters

  ## Examples

      iex> get_feedback("dream", "dream")
      [:green, :green, :green, :green, :green]

      iex> get_feedback("dream", "cream")
      [:red, :green, :green, :green, :green]

      iex> get_feedback("dream", "smear")
      [:red, :yellow, :green, :green, :yellow]
  """

  def get_answer() do
    Enum.random(["bingo", "train", "sleek", "house", "flyer"])
  end

  def get_feedback(target, guess) do
    {String.graphemes(target), String.graphemes(guess)}
    |> find_green_matches()
    |> find_yellow_partials()
    |> find_red_nonmatches()
  end

  def find_green_matches({target_chars, guessed_chars}) do
    Enum.zip([target_chars, guessed_chars])
    |> Enum.map(fn
      {same, same} -> {nil, :green}
      {tar, guess} -> {tar, guess}
    end)
    |> Enum.unzip()
  end

  def find_yellow_partials({target_chars, guessed_chars}) do
    Enum.reduce(guessed_chars, {target_chars, []}, fn guess, {target_chars, updated} ->
      if guess in target_chars do
        {List.delete(target_chars, guess), List.insert_at(updated, -1, :yellow)}
      else
        {target_chars, List.insert_at(updated, -1, guess)}
      end
    end)
  end

  def find_red_nonmatches({_target_chars, guessed_chars}) do
    Enum.map(guessed_chars, fn char ->
      if char in [:yellow, :green] do
        char
      else
        :red
      end
    end)
  end

  @doc """
  DEPRECATED: Original word evaluation function
  """
  @spec feedback(String.t(), String.t()) :: list()
  def feedback(target, guess) do
    # Count occurrences of each letter in the target word
    target_counts = String.graphemes(target) |> Enum.frequencies()

    # First find all green (letter and location) matches, and remaining letters to be found.
    # This helps with accurate counting of green and yellow matches
    {green_matches, remaining_counts} =
      Enum.map([target, guess], &String.graphemes/1)
      |> Enum.zip()
      |> Enum.reduce({[], target_counts}, fn {target_char, guess_char}, {so_far, counts} ->
        if target_char === guess_char do
          {[:green | so_far], Map.update!(counts, target_char, &(&1 - 1))}
        else
          {[guess_char | so_far], counts}
        end
      end)

    # Return green and remaining yellow and red non-matches
    Enum.reduce(green_matches, {[], remaining_counts}, fn
      :green, {so_far, counts} ->
        {[:green | so_far], counts}

      char, {so_far, counts} ->
        case counts[char] do
          nil -> {[:red | so_far], counts}
          0 -> {[:red | so_far], counts}
          _ -> {[:yellow | so_far], Map.update!(counts, char, &(&1 - 1))}
        end
    end)
    |> elem(0)
  end
end
