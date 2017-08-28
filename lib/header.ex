defmodule Parser.Header do
  defstruct [:source, :dest, :date, :subm, :subn, :file, :copr, :gedc, :char, :lang, :plac, :note]

  require Parser.Macros

  @nodes %{
    "SOUR" => [key: :source, module: Parser.Source],
    "DEST" => [key: :dest],
    "SUBM" => [key: :subm]
  }

  @definition %{
    root_value: nil,
    nodes: @nodes
  }

  Parser.Macros.build_model_processor @definition
end
