defmodule Parser.Data do
  defstruct [:name, :date, :copyright]

  require Parser.Macros

  @nodes %{
    "DATE" => [key: :date],
    "COPR" => [key: :copyright]
  }

  @definition %{
    root_value: :name,
    nodes: @nodes
  }

  Parser.Macros.build_model_processor @definition
end
