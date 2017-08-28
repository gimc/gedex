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

  defmacro build_node_processor(definition) do
    quote bind_quoted: [definition: definition] do
      Parser.Macros.build_leaf_processors definition.leaf_nodes
      Parser.Macros.build_child_processors definition.child_nodes

      def process_lines([source_line | rest]) do
        source =
          if (unquote(definition.root_value) != nil) do
            Map.put(%__MODULE__{}, unquote(definition.root_value), source_line.value)
          else
            %__MODULE__{}
          end

        process_lines(rest, source_line.level, source)
      end

      defp process_lines([], _parent_level, source), do: {[], source}

      defp process_lines([%{level: level} | _rest] = lines, parent_level, source) when level <= parent_level
      do
        {lines, source}
      end
    end
  end
end
