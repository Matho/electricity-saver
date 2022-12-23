require "application_system_test_case"

class SmartPlugDevicesTest < ApplicationSystemTestCase
  setup do
    @smart_plug_device = smart_plug_devices(:one)
  end

  test "visiting the index" do
    visit smart_plug_devices_url
    assert_selector "h1", text: "Smart plug devices"
  end

  test "should create smart plug device" do
    visit smart_plug_devices_url
    click_on "New smart plug device"

    fill_in "Api title", with: @smart_plug_device.api_title
    fill_in "Current state", with: @smart_plug_device.current_state
    fill_in "Description", with: @smart_plug_device.description
    fill_in "Ip address", with: @smart_plug_device.ip_address
    fill_in "Network", with: @smart_plug_device.network_id
    fill_in "Title", with: @smart_plug_device.title
    click_on "Create Smart plug device"

    assert_text "Smart plug device was successfully created"
    click_on "Back"
  end

  test "should update Smart plug device" do
    visit smart_plug_device_url(@smart_plug_device)
    click_on "Edit this smart plug device", match: :first

    fill_in "Api title", with: @smart_plug_device.api_title
    fill_in "Current state", with: @smart_plug_device.current_state
    fill_in "Description", with: @smart_plug_device.description
    fill_in "Ip address", with: @smart_plug_device.ip_address
    fill_in "Network", with: @smart_plug_device.network_id
    fill_in "Title", with: @smart_plug_device.title
    click_on "Update Smart plug device"

    assert_text "Smart plug device was successfully updated"
    click_on "Back"
  end

  test "should destroy Smart plug device" do
    visit smart_plug_device_url(@smart_plug_device)
    click_on "Destroy this smart plug device", match: :first

    assert_text "Smart plug device was successfully destroyed"
  end
end
