defmodule Parser.Macros do

  defmacro build_node_processors(nodes) do
    quote bind_quoted: [nodes: nodes] do
      Enum.each(nodes, fn {tag, options} ->
        if (options[:module]) do
          defp process_lines([%{tag: unquote(tag)} | _rest] = lines, parent_level, source) do
            {lines, value} = unquote(options[:module]).process_lines(lines)
            process_lines(lines, parent_level, Map.put(source, unquote(options[:key]), value))
          end
        else
          defp process_lines([%{tag: unquote(tag), value: value, xref_id: ""} | rest], parent_level, source) do
            process_lines(rest, parent_level, Map.put(source, unquote(options[:key]), value))
          end

          defp process_lines([%{tag: unquote(tag), value: "", xref_id: xref_id} | rest], parent_level, source) do
            process_lines(rest, parent_level, Map.put(source, unquote(options[:key]), xref_id))
          end
        end
      end)
    end
  end

  defmacro build_model_processor(definition) do
    quote bind_quoted: [definition: definition] do
      Parser.Macros.build_node_processors definition.nodes

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
