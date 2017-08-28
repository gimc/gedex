defmodule Parser.Family.Event.Husb do
  defstruct [:age]

  require Parser.Macros

  Parser.Macros.build_model_processor %{
    root_value: nil,
    nodes: %{
      "AGE" => [key: :age]
    }
  }
end
