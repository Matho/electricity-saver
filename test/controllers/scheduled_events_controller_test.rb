require "test_helper"

class ScheduledEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scheduled_event = scheduled_events(:one)
  end

  test "should get index" do
    get scheduled_events_url
    assert_response :success
  end

  test "should get new" do
    get new_scheduled_event_url
    assert_response :success
  end

  test "should create scheduled_event" do
    assert_difference("ScheduledEvent.count") do
      post scheduled_events_url, params: { scheduled_event: { action: @scheduled_event.action, event_date: @scheduled_event.event_date, smart_plug_device_id: @scheduled_event.smart_plug_device_id } }
    end

    assert_redirected_to scheduled_event_url(ScheduledEvent.last)
  end

  test "should show scheduled_event" do
    get scheduled_event_url(@scheduled_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_scheduled_event_url(@scheduled_event)
    assert_response :success
  end

  test "should update scheduled_event" do
    patch scheduled_event_url(@scheduled_event), params: { scheduled_event: { action: @scheduled_event.action, event_date: @scheduled_event.event_date, smart_plug_device_id: @scheduled_event.smart_plug_device_id } }
    assert_redirected_to scheduled_event_url(@scheduled_event)
  end

  test "should destroy scheduled_event" do
    assert_difference("ScheduledEvent.count", -1) do
      delete scheduled_event_url(@scheduled_event)
    end

    assert_redirected_to scheduled_events_url
  end
end
