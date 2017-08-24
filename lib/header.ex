defmodule Parser.Header do
  defstruct [:source, :dest, :date, :subm, :subn, :file, :copr, :gedc, :char, :lang, :plac, :note]

  alias Parser.Line
  alias Parser.Source

  def process_line(%Line{tag: "SOUR"} = line, {parent, lines, lineage}) do
    {parent, lines, source} =
      Source.process_lines(lines)
  end
end
