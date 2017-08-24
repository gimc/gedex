defmodule Parser.Source do
  alias Parser.Corp
  alias Parser.Data

  require Parser.Macros

  defstruct [:system_id, :version, :name, :corp, :source_data]

  # @child_tags %{
  #   "\"VERS\"" => "version",
  #   "\"NAME\"" => "name"
  #   "CORP" => {"corp", Corp},
  #   "DATA" => {"data", Data}
  # }

  # Macros.gen_funs(@child_tags)

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

  defp process_lines([%{tag: "VERS", value: version} | rest], parent_level, source)  do
    process_lines(rest, parent_level, %{source | version: version})
  end

  defp process_lines([%{tag: "NAME", value: name} | rest], parent_level, source) do
    process_lines(rest, parent_level, %{source | name: name})
  end

  defp process_lines([%{tag: "CORP"} | _rest] = lines, parent_level, source) do
    {lines, corp} = Corp.process_lines(lines)
    process_lines(lines, parent_level, %{source | corp: corp})
  end

  defp process_lines([%{tag: "DATA"} | _rest] = lines, parent_level, source) do
    {lines, data} = Data.process_lines(lines)
    process_lines(lines, parent_level, %{source | source_data: data})
  end

end
