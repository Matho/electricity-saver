require "application_system_test_case"

class EventLogsTest < ApplicationSystemTestCase
  setup do
    @event_log = event_logs(:one)
  end

  test "visiting the index" do
    visit event_logs_url
    assert_selector "h1", text: "Event logs"
  end

  test "should create event log" do
    visit event_logs_url
    click_on "New event log"

    fill_in "Endpoint device", with: @event_log.endpoint_device_id
    fill_in "Event date", with: @event_log.event_date
    fill_in "Title", with: @event_log.title
    click_on "Create Event log"

    assert_text "Event log was successfully created"
    click_on "Back"
  end

  test "should update Event log" do
    visit event_log_url(@event_log)
    click_on "Edit this event log", match: :first

    fill_in "Endpoint device", with: @event_log.endpoint_device_id
    fill_in "Event date", with: @event_log.event_date
    fill_in "Title", with: @event_log.title
    click_on "Update Event log"

    assert_text "Event log was successfully updated"
    click_on "Back"
  end

  test "should destroy Event log" do
    visit event_log_url(@event_log)
    click_on "Destroy this event log", match: :first

    assert_text "Event log was successfully destroyed"
  end
end
