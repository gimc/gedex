defmodule Parser.Data do
  defstruct [:name, :date, :copyright]

  def process_lines([root | rest]) do
    data = %__MODULE__{
      name: root.value
    }

    process_lines(rest, root.level, data)
  end

  defp process_lines([], _root_level, data), do: {[], data}
  defp process_lines([%{level: level} | _rest] = lines, root_level, data) when level <= root_level, do: {lines, data}

  defp process_lines([%{tag: "DATE", value: date} | rest], root_level, data) do
    process_lines(rest, root_level, %{data | date: date})
  end

  defp process_lines([%{tag: "COPR", value: copyright} | rest], root_level, data) do
    process_lines(rest, root_level,%{data | copyright: copyright})
  end
end
