defmodule FamilyTest do
  use ExUnit.Case
  alias Parser.Family
  alias Parser.Line

  test "parse Family (FAM)" do
    {lines, family} =
      """
        1 @100@ FAM
          2 MARR
            3 DATE 20 AUG 2017
            3 HUSB
              4 AGE 30
            3 WIFE
              4 AGE 30
          2 HUSB @200@
          2 WIFE @300@
          2 CHIL @400@
          2 CHIL @401@
          2 NCHI 2
          2 SUBM @567@
          2 CHAN 20 AUG 2017
      """
    |> Line.to_list
    |> Family.process_lines
  end
end
