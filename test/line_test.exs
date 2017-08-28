defmodule LineTest do
  use ExUnit.Case
  alias Parser.Line

  test "parse tag-only line" do
    line = Line.from_string("0 HEAD")

    assert line.level == 0
    assert line.tag == "HEAD"
  end

  test "parse tag + value line" do
    line = Line.from_string("1 SOUR PAF")

    assert line.level == 1
    assert line.tag == "SOUR"
    assert line.value == "PAF"
  end

  test "parse record with reference line" do
    line = Line.from_string("0 @1@ INDI")

    assert line.level == 0
    assert line.xref_id == "1"
    assert line.tag == "INDI"
  end

  test "parse cross-reference line" do
    line = Line.from_string("2 SOUR @6@")

    assert line.level == 2
    assert line.tag == "SOUR"
    assert line.value == "@6@"
  end

  test "block parsing" do
    block = """
      1 SOUR Test_Source
        2 VERS 1.0
        2 NAME GedEx
      1 DEST Destination
    """

    lines = Line.to_list(block)

    assert length(lines) == 4
  end
end
