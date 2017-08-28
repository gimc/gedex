defmodule Parser.Source do
  require Parser.Macros

  defstruct [:system_id, :version, :name, :corp, :source_data]

  @leaf_nodes %{
    "VERS" => %{
      key: :version
    },
    "NAME" => %{
      key: :name
    }
  }

  @child_nodes %{
    "CORP" => %{
      module: Parser.Corp,
      key: :corp
    },
    "DATA" => %{
      module: Parser.Data,
      key: :source_data
    }
  }

  @definition %{
    root_value: :system_id,
    leaf_nodes: @leaf_nodes,
    child_nodes: @child_nodes
  }

  Parser.Macros.build_node_processor @definition
end
