defmodule Parser.Date do
  defstruct [:date, :time]

  require Parser.Macros

  Parser.Macros.build_model_processor %{
    root_value: :date,
    nodes: %{
      "TIME" => [key: :time]
    }
  }
end
