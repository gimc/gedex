defmodule Parser.Line do
  defstruct [:level, :xref_id, :tag, :value]

  @type t :: %__MODULE__{
    level: integer,
    xref_id: String.t,
    tag: String.t,
    value: String.t
  }

  @regex ~r/(?<level>\d+) (?<xref_id>@[\w]+@)? ?(?<tag>\w+)(?<value>.*+)?/

  def from_string(string) do
    captures = Regex.named_captures(@regex, string, capture: :all_but_first)
    
    %__MODULE__{
      level: String.to_integer(captures["level"], 10),
      xref_id: String.trim(captures["xref_id"]),
      tag: String.trim(captures["tag"]),
      value: String.trim(captures["value"])
    }
  end

  def to_list(multiline_string) do
    multiline_string
    |> String.split("\n")
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&from_string/1)
    |> Enum.to_list
  end
end
