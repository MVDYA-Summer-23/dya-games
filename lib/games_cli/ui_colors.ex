defmodule GamesCLI.UI.Colors do
  def values() do
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
end
