require "application_system_test_case"

class VisitorTablesTest < ApplicationSystemTestCase
  setup do
    @visitor_table = visitor_tables(:one)
  end

  test "visiting the index" do
    visit visitor_tables_url
    assert_selector "h1", text: "Visitor tables"
  end

  test "should create visitor table" do
    visit visitor_tables_url
    click_on "New visitor table"

    fill_in "Classification", with: @visitor_table.classification
    fill_in "Last visited", with: @visitor_table.last_visited
    fill_in "Name", with: @visitor_table.name
    fill_in "No of visits", with: @visitor_table.no_of_visits
    fill_in "Notes", with: @visitor_table.notes
    fill_in "Relation", with: @visitor_table.relation
    click_on "Create Visitor table"

    assert_text "Visitor table was successfully created"
    click_on "Back"
  end

  test "should update Visitor table" do
    visit visitor_table_url(@visitor_table)
    click_on "Edit this visitor table", match: :first

    fill_in "Classification", with: @visitor_table.classification
    fill_in "Last visited", with: @visitor_table.last_visited
    fill_in "Name", with: @visitor_table.name
    fill_in "No of visits", with: @visitor_table.no_of_visits
    fill_in "Notes", with: @visitor_table.notes
    fill_in "Relation", with: @visitor_table.relation
    click_on "Update Visitor table"

    assert_text "Visitor table was successfully updated"
    click_on "Back"
  end

  test "should destroy Visitor table" do
    visit visitor_table_url(@visitor_table)
    click_on "Destroy this visitor table", match: :first

    assert_text "Visitor table was successfully destroyed"
  end
end
