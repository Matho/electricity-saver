require "application_system_test_case"

class UptimeStatsTest < ApplicationSystemTestCase
  setup do
    @uptime_stat = uptime_stats(:one)
  end

  test "visiting the index" do
    visit uptime_stats_url
    assert_selector "h1", text: "Uptime stats"
  end

  test "should create uptime stat" do
    visit uptime_stats_url
    click_on "New uptime stat"

    check "Available" if @uptime_stat.available
    fill_in "Check date", with: @uptime_stat.check_date
    fill_in "Endpoint device", with: @uptime_stat.endpoint_device_id
    fill_in "Network", with: @uptime_stat.network_id
    click_on "Create Uptime stat"

    assert_text "Uptime stat was successfully created"
    click_on "Back"
  end

  test "should update Uptime stat" do
    visit uptime_stat_url(@uptime_stat)
    click_on "Edit this uptime stat", match: :first

    check "Available" if @uptime_stat.available
    fill_in "Check date", with: @uptime_stat.check_date
    fill_in "Endpoint device", with: @uptime_stat.endpoint_device_id
    fill_in "Network", with: @uptime_stat.network_id
    click_on "Update Uptime stat"

    assert_text "Uptime stat was successfully updated"
    click_on "Back"
  end

  test "should destroy Uptime stat" do
    visit uptime_stat_url(@uptime_stat)
    click_on "Destroy this uptime stat", match: :first

    assert_text "Uptime stat was successfully destroyed"
  end
end
