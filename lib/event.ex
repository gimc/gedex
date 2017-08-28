defmodule Parser.Event do
  defstruct [:type, :date_value, :place_structure, :address_structure,
             :age_at_event, :responsible_agency, :cause_of_event,
             :source_citations, :multimedia_links, :note_structures]

  require Parser.Macros

  Parser.Macros.build_model_processor %{
    root_value: nil,
    nodes: %{
      "TYPE" => [key: :type],
      "DATE" => [key: :date_value],
      "AGE" => [key: :age_at_event],
      "AGNC" => [key: :responsible_agency],
      "CAUS" => [key: :cause_of_event]
    }
  }
end
