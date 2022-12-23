require "application_system_test_case"

class PingStatsTest < ApplicationSystemTestCase
  setup do
    @ping_stat = ping_stats(:one)
  end

  test "visiting the index" do
    visit ping_stats_url
    assert_selector "h1", text: "Ping stats"
  end

  test "should create ping stat" do
    visit ping_stats_url
    click_on "New ping stat"

    fill_in "Ip addresss", with: @ping_stat.ip_addresss
    fill_in "Response code", with: @ping_stat.response_code
    fill_in "Response status", with: @ping_stat.response_status
    fill_in "Response time", with: @ping_stat.response_time
    click_on "Create Ping stat"

    assert_text "Ping stat was successfully created"
    click_on "Back"
  end

  test "should update Ping stat" do
    visit ping_stat_url(@ping_stat)
    click_on "Edit this ping stat", match: :first

    fill_in "Ip addresss", with: @ping_stat.ip_addresss
    fill_in "Response code", with: @ping_stat.response_code
    fill_in "Response status", with: @ping_stat.response_status
    fill_in "Response time", with: @ping_stat.response_time
    click_on "Update Ping stat"

    assert_text "Ping stat was successfully updated"
    click_on "Back"
  end

  test "should destroy Ping stat" do
    visit ping_stat_url(@ping_stat)
    click_on "Destroy this ping stat", match: :first

    assert_text "Ping stat was successfully destroyed"
  end
end
