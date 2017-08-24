defmodule AddressTest do
  use ExUnit.Case
  alias Parser.Address
  alias Parser.Line

  test "parse address block (ADDR)" do
    block = """
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
    """

    lines = Line.to_list(block)

    {lines, address} = Address.process_lines(lines)

    assert address.line == "Flat 3/14\n123 Fake Street"
    assert address.country == "USA"
    assert length(address.phone_numbers) == 3
  end
end
