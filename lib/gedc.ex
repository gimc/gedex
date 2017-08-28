defmodule Parser.Gedc do
  defstruct [:version, :form]

  require Parser.Macros

  Parser.Macros.build_model_processor %{
    root_value: nil,
    nodes: %{
      "VERS" => [key: :version],
      "FORM" => [key: :form]
    }
  }
end
