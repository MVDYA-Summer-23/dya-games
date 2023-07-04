IEx.configure(inspect: [charlists: :as_lists])
alias GamesCLI.Wordle

colors = fn -> Owl.Palette.rgb() |> Owl.IO.puts() end
