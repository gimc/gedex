defmodule Parser.Corp do
  defstruct [:name, :address]

  require Parser.Macros

  @child_nodes %{
    "ADDR" => %{
      module: Parser.Address,
      key: :address
    }
  }

  @definition %{
    root_value: :name,
    leaf_nodes: %{},
    child_nodes: @child_nodes
  }

  Parser.Macros.build_node_processor @definition
end
