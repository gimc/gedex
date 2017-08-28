defmodule Parser.Char do
  defstruct [:character_set, :version]

  require Parser.Macros

  Parser.Macros.build_model_processor %{
    root_value: :character_set,
    nodes: %{
      "VERS" => [key: :version]
    }
  }
end
