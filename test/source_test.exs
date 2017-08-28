defmodule SourceTest do
  use ExUnit.Case
  alias Parser.Source
  alias Parser.Line

  test "parse source block (SOUR)" do
    block = """
      1 SOUR Test_Source
        2 VERS 1.0
        2 NAME GedEx
        2 CORP GedCorp
          3 ADDR Flat 3/14
            4 CONT 123 Fake Street
            4 ADR1 Address line 1
            4 ADR2 Address line 2
            4 CITY Springfield
            4 STAE The state Springield is in
            4 POST 13395
            4 CTRY USA
          3 PHON 555-123456
          3 PHON 555-110010
          3 PHON 555-189201
        2 DATA <NAME_OF_SOURCE_DATA>  {0:1}
          3 DATE <PUBLICATION_DATE>  {0:1}
          3 COPR <COPYRIGHT_SOURCE_DATA>  {0:1}
      1 DEST Destination
    """

    lines = Line.to_list(block)

    {lines, source} = Source.process_lines(lines)
    
    next_line = List.first(lines)
    assert next_line.tag == "DEST"
    assert source.system_id == "Test_Source"
    assert source.version == "1.0"
    assert source.name == "GedEx"
    assert source.corp.address.line == "Flat 3/14\n123 Fake Street"
    assert source.corp.address.country == "USA"
    assert length(source.corp.address.phone_numbers) == 3
  end
end
