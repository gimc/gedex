defmodule HeaderTest do
  use ExUnit.Case
  alias Parser.Header
  alias Parser.Line

  test "parse header block (HEAD)" do
    {lines, header} =
      """
      0 HEAD
        1 SOUR Test_Source
        1 DEST Destination
        1 DATE 28 AUG 2017
          2 TIME 21:00
        1 SUBM @123@
        1 SUBN @125@
        1 FILE test.ged
        1 COPR None
        1 GEDC
          2 VERS 1.0
          2 FORM LINEAGE-LINKED
        1 CHAR ASCII
          2 VERS 1.1
        1 LANG English
        1 PLAC
          2 FORM Place hierarchy
        1 NOTE Test
          2 CONC header
          2 CONT data
      """
      |> Line.to_list
      |> Header.process_lines

    assert header.source.system_id == "Test_Source"
    assert header.dest == "Destination"
    assert header.transmission_date.date == "28 AUG 2017"
    assert header.transmission_date.time == "21:00"
    assert header.subm == "@123@"
    assert header.subn == "@125@"
    assert header.file == "test.ged"
    assert header.copr == "None"
    assert header.gedc.version == "1.0"
    assert header.gedc.form == "LINEAGE-LINKED"
    assert header.char.character_set == "ASCII"
    assert header.char.version == "1.1"
    assert header.lang == "English"
    assert header.plac.place_hierarchy == "Place hierarchy"
    assert header.note == "Testheader\ndata"
  end
end
