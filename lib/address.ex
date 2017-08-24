defmodule Parser.Address do
  defstruct [:line, :line1, :line2, :city, :state, :postal_code, :country, phone_numbers: []]

  @type t :: %__MODULE__{
    line: String.t,
    line1: String.t,
    line2: String.t,
    city: String.t,
    state: String.t,
    postal_code: String.t,
    country: String.t,
    phone_numbers: [String.t]
  }

  alias Parser.Line

  def process_lines([%{tag: "ADDR", value: value, level: level} | rest]) do
    address = %__MODULE__{
      line: value
    }

    process_lines(rest, level, address)
  end

  defp process_lines([], _root_level, address), do: {[], address}
  defp process_lines([%{level: level} | _rest] = lines, root_level, address) when level < root_level, do: {lines, address}
  defp process_lines([%{tag: "PHON", level: level, value: phone_number} | rest], root_level, address) when level == root_level do
    process_lines(rest, root_level, %{address | phone_numbers: [phone_number | address.phone_numbers]})
  end
  defp process_lines([%{level: level} | _rest] = lines, root_level, address) when level == root_level, do: {lines, address}

  defp process_lines([%{tag: "CONT", value: line} | rest], root_level, address) do
    process_lines(rest, root_level, %{address | line: address.line <> "\n" <> line})
  end

  defp process_lines([%{tag: "ADR1", value: line1} | rest], root_level, address) do
    process_lines(rest, root_level, %{address | line1: line1})
  end

  defp process_lines([%{tag: "ADR2", value: value} | rest], root_level, address) do
    process_lines(rest, root_level, %{address | line2: value})
  end

  defp process_lines([%{tag: "CITY", value: value} | rest], root_level, address) do
    process_lines(rest, root_level, %{address | city: value})
  end

  defp process_lines([%{tag: "STAE", value: value} | rest], root_level, address) do
    process_lines(rest, root_level, %{address | state: value})
  end

  defp process_lines([%{tag: "POST", value: value} | rest], root_level, address) do
    process_lines(rest, root_level, %{address | postal_code: value})
  end

  defp process_lines([%{tag: "CTRY", value: value} | rest], root_level, address) do
    process_lines(rest, root_level, %{address | country: value})
  end
end
