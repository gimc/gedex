defmodule Parser.Source do
  require Parser.Macros

  defstruct [:system_id, :version, :name, :corp, :source_data]

  @nodes %{
    "VERS" => [key: :version],
    "NAME" => [key: :name],
    "CORP" => [key: :corp, module: Parser.Corp],
    "DATA" => [key: :data, module: Parser.Data]
  }

  @definition %{
    root_value: :system_id,
    nodes: @nodes
  }

  Parser.Macros.build_model_processor @definition
end
