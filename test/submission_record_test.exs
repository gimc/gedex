defmodule SubmissionRecordTest do
  use ExUnit.Case
  alias Parser.SubmissionRecord
  alias Parser.Line

  test "parse Submission Record (SUBN)" do
    {lines, submission_record} =
      """
      1 @123@ SUBN
        2 SUBM @125@
        2 FAMF TempleFamilyFileName
        2 TEMP TempleCode
        2 ANCE 10
        2 DESC 10
        2 ORDI yes
        2 RIN 123456
      """
      |> Line.to_list
      |> SubmissionRecord.process_lines

    assert submission_record.id == "123"
    assert submission_record.subm_id == "125"
    assert submission_record.rin == "123456"
  end
end
