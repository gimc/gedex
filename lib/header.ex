defmodule Parser.Header do
  defstruct [:source, :dest, :transmission_date, :subm, :subn, :file, :copr, :gedc, :char, :lang, :plac, :note]

  require Parser.Macros

  @nodes %{
    "SOUR" => [key: :source, module: Parser.Source],
    "DEST" => [key: :dest],
    "DATE" => [key: :transmission_date, module: Parser.Date],
    "SUBM" => [key: :subm],
    "SUBN" => [key: :subn],
    "FILE" => [key: :file],
    "COPR" => [key: :copr],
    "GEDC" => [key: :gedc, module: Parser.Gedc],
    "CHAR" => [key: :char, module: Parser.Char],
    "LANG" => [key: :lang],
    "PLAC" => [key: :plac, module: Parser.Plac],
    "NOTE" => [key: :note, module: Parser.Note]
  }

  @definition %{
    root_value: nil,
    nodes: @nodes
  }

  Parser.Macros.build_model_processor @definition
end
