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
      key: :data
    }
  }

  Parser.Macros.build_leaf_processors @leaf_nodes
  Parser.Macros.build_child_processors @child_nodes

  def process_lines([source_line | rest]) do
    source = %__MODULE__{
      system_id: source_line.value
    }

    process_lines(rest, source_line.level, source)
  end

  defp process_lines([], _parent_level, source), do: {[], source}

  defp process_lines([%{level: level} | _rest] = lines, parent_level, source) when level == parent_level
  do
    {lines, source}
  end
end
