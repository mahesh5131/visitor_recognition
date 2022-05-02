require "test_helper"

class VisitorTablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visitor_table = visitor_tables(:one)
  end

  test "should get index" do
    get visitor_tables_url
    assert_response :success
  end

  test "should get new" do
    get new_visitor_table_url
    assert_response :success
  end

  test "should create visitor_table" do
    assert_difference("VisitorTable.count") do
      post visitor_tables_url, params: { visitor_table: { classification: @visitor_table.classification, last_visited: @visitor_table.last_visited, name: @visitor_table.name, no_of_visits: @visitor_table.no_of_visits, notes: @visitor_table.notes, relation: @visitor_table.relation } }
    end

    assert_redirected_to visitor_table_url(VisitorTable.last)
  end

  test "should show visitor_table" do
    get visitor_table_url(@visitor_table)
    assert_response :success
  end

  test "should get edit" do
    get edit_visitor_table_url(@visitor_table)
    assert_response :success
  end

  test "should update visitor_table" do
    patch visitor_table_url(@visitor_table), params: { visitor_table: { classification: @visitor_table.classification, last_visited: @visitor_table.last_visited, name: @visitor_table.name, no_of_visits: @visitor_table.no_of_visits, notes: @visitor_table.notes, relation: @visitor_table.relation } }
    assert_redirected_to visitor_table_url(@visitor_table)
  end

  test "should destroy visitor_table" do
    assert_difference("VisitorTable.count", -1) do
      delete visitor_table_url(@visitor_table)
    end

    assert_redirected_to visitor_tables_url
  end
end
