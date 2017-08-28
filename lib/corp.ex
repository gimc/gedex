defmodule Parser.Corp do
  defstruct [:name, :address]

  require Parser.Macros

  @nodes %{
    "ADDR" => [key: :address, module: Parser.Address]
  }

  @definition %{
    root_value: :name,
    nodes: @nodes
  }

  Parser.Macros.build_model_processor @definition
end
