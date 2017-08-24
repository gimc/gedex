defmodule Parser.Corp do
  defstruct [:name, :address]

  alias Parser.Address

  def process_lines([root | rest]) do
    corp = %__MODULE__{
      name: root.value
    }

    process_lines(rest, root.level, corp)
  end

  defp process_lines([], _root_level, corp), do: {[], corp}
  defp process_lines([%{level: level} | _rest] = lines, root_level, corp) when level <= root_level, do: {lines, corp}
  defp process_lines([%{tag: "ADDR"} | _rest] = lines, _root_level, corp) do
    {lines, address} = Address.process_lines(lines)
    {lines, %{corp | address: address}}
  end
end
