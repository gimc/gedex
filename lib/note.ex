defmodule Parser.Note do
  def process_lines([%{tag: "NOTE", value: note} | rest]) do
    process_lines(rest, note)
  end

  defp process_lines([%{tag: "CONC", value: text} | rest], note) do
    process_lines(rest, note <> text)
  end

  defp process_lines([%{tag: "CONT", value: text} | rest], note) do
    process_lines(rest, note <> "\n" <> text)
  end

  defp process_lines(lines, note), do: {lines, note}
end
