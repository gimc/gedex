defmodule Parser.Family do
  defstruct [:id, :family_events, :husband, :wife, :children, :num_children, :submission_ids,
             :lds_spouse_sealings, :source_citations, :multimedia_links, :note_structures, :user_reference_numbers, :rin, :change_date]

  require Parser.Macros

  @event_types ["ANUL", "CENS", "DIV", "DIVF",
                "ENGA", "MARR", "MARB", "MARC",
                "MARL", "MARS"]

  Parser.Macros.build_model_processor %{
    root_value: nil,
    nodes: %{
      "HUSB" => [key: :husband, foreign_key: true],
      "WIFE" => [key: :wife, foreign_key: true],
      "CHIL" => [key: :children, foreign_key: true],
      "NCHI" => [key: :num_children],
      "SUBM" => [key: :submission_ids, foreign_key: true],
      "CHAN" => [key: :change_date]
    }
  }

  defp process_lines([%{tag: event_type} | rest] = lines, level, family) when event_type in @event_types do
    {lines, event} = Parser.Family.Event.process_lines(lines)
    process_lines(lines, level, Map.update!(family, :family_events, &([event | &1])))
  end
end
