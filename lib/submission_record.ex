defmodule Parser.SubmissionRecord do
  defstruct [:id, :subm_id, :family_file, :temple_code, :ance, :desc, :ordi, :rin]

  require Parser.Macros

  Parser.Macros.build_model_processor %{
    root_value: nil,
    nodes: %{
      "SUBM" => [key: :subm_id, foreign_key: true],
      "FAMF" => [key: :family_file],
      "TEMP" => [key: :temple_code],
      "ANCE" => [key: :ance],
      "DESC" => [key: :describe],
      "ORDI" => [key: :ordi],
      "RIN" => [key: :rin]
    }
  }
end
