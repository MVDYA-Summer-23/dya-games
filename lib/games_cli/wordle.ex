defmodule GamesCLI.Wordle do
  alias Owl.{Box, Data}

  @colors GamesCLI.UI.Colors.values().foreground

  # This is the only game title scenario that doesn't break the bounding box while still centering
  @wordle_letters [
    Data.tag("W", [@colors.green, :bright]),
    " ",
    Data.tag("O", [@colors.yellow, :bright]),
    " ",
    Data.tag("R", [@colors.red, :bright]),
    " ",
    Data.tag("D", [@colors.green, :bright]),
    " ",
    Data.tag("L", [@colors.yellow, :bright]),
    " ",
    Data.tag("E", [@colors.red, :bright])
  ]

  @game_header_text Enum.concat([["***   "], @wordle_letters, ["   ***"]])

  def start() do
    show_game_header()
    show_game_rules()
    play()
  end

  def show_game_header() do
    Box.new(@game_header_text,
      border_style: :double,
      min_width: 70,
      horizontal_align: :center,
      padding_y: 1,
      border_tag: :cyan
    )
    |> Owl.IO.puts()
  end

  def show_game_rules(word_length \\ 5) do
    [
      Box.new("Rules",
        padding_bottom: 1,
        min_width: 64,
        border_style: :none,
        horizontal_align: :center
      ),
      Box.new(
        [
          """
          Try to guess a random #{word_length}-letter English word in six tries!
          For each guess, you'll see colored feedback for each letter:\n
          """,
          "* ",
          Data.tag("green", :green),
          ": you guessed correctly\n",
          "* ",
          Data.tag("yellow", :yellow),
          ": the letter is in the word, but in the wrong place\n",
          "* ",
          Data.tag("red", :red),
          ": the letter is not in the word."
        ],
        min_width: 64,
        border_style: :none
      )
    ]
    |> Box.new(max_width: 70, padding_x: 2, padding_y: 1)
    |> Owl.IO.puts()
  end

  def play do
    "HOLA"
  end
end
