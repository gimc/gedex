defmodule Parser.Macros do
  defmacro build_leaf_processors(tags) do
    quote bind_quoted: [tags: tags] do
      Enum.each(tags, fn {k, v} ->
        defp process_lines([%{tag: unquote(k), value: value} | rest], parent_level, source) do
          process_lines(rest, parent_level, Map.put(source, unquote(v.key), value))
        end
      end)
    end
  end

  defmacro build_child_processors(tags) do
    quote bind_quoted: [tags: tags] do
      Enum.each(tags, fn {k, v} ->
        defp process_lines([%{tag: unquote(k)} | _rest] = lines, parent_level, source) do
          {lines, value} = unquote(v.module).process_lines(lines)
          process_lines(lines, parent_level, Map.put(source, unquote(v.key), value))
        end
      end)
    end
  end
end
