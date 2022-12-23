require "application_system_test_case"

class ScheduledEventsTest < ApplicationSystemTestCase
  setup do
    @scheduled_event = scheduled_events(:one)
  end

  test "visiting the index" do
    visit scheduled_events_url
    assert_selector "h1", text: "Scheduled events"
  end

  test "should create scheduled event" do
    visit scheduled_events_url
    click_on "New scheduled event"

    fill_in "Action", with: @scheduled_event.action
    fill_in "Event date", with: @scheduled_event.event_date
    fill_in "Smart plug device", with: @scheduled_event.smart_plug_device_id
    click_on "Create Scheduled event"

    assert_text "Scheduled event was successfully created"
    click_on "Back"
  end

  test "should update Scheduled event" do
    visit scheduled_event_url(@scheduled_event)
    click_on "Edit this scheduled event", match: :first

    fill_in "Action", with: @scheduled_event.action
    fill_in "Event date", with: @scheduled_event.event_date
    fill_in "Smart plug device", with: @scheduled_event.smart_plug_device_id
    click_on "Update Scheduled event"

    assert_text "Scheduled event was successfully updated"
    click_on "Back"
  end

  test "should destroy Scheduled event" do
    visit scheduled_event_url(@scheduled_event)
    click_on "Destroy this scheduled event", match: :first

    assert_text "Scheduled event was successfully destroyed"
  end
end
