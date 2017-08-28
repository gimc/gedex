defmodule Parser.Header do
  defstruct [:source, :dest, :date, :subm, :subn, :file, :copr, :gedc, :char, :lang, :plac, :note]

  require Parser.Macros

  @child_nodes %{
    "SOUR" => %{
      module: Parser.Source,
      key: :source
    }
  }

  @leaf_nodes %{
    "DEST" => %{
      key: :dest
    },
    "SUBM" => %{
      key: :subm
    }
  }

  @definition %{
    root_value: nil,
    leaf_nodes: @leaf_nodes,
    child_nodes: @child_nodes
  }

  Parser.Macros.build_node_processor @definition
end
