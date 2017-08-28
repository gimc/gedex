defmodule Parser.Data do
  defstruct [:name, :date, :copyright]

  require Parser.Macros

  @leaf_nodes %{
    "DATE" => %{
      key: :date
    },
    "COPR" => %{
      key: :copyright
    }
  }

  @definition %{
    root_value: :name,
    leaf_nodes: @leaf_nodes,
    child_nodes: %{}
  }

  Parser.Macros.build_node_processor @definition
end
