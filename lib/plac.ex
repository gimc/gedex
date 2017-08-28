defmodule Parser.Plac do
  defstruct [:place_hierarchy]

  require Parser.Macros

  Parser.Macros.build_model_processor %{
    root_value: nil,
    nodes: %{
      "FORM" => [key: :place_hierarchy]
    }
  }
end
