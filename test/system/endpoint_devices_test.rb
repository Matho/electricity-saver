require "application_system_test_case"

class EndpointDevicesTest < ApplicationSystemTestCase
  setup do
    @endpoint_device = endpoint_devices(:one)
  end

  test "visiting the index" do
    visit endpoint_devices_url
    assert_selector "h1", text: "Endpoint devices"
  end

  test "should create endpoint device" do
    visit endpoint_devices_url
    click_on "New endpoint device"

    fill_in "Contact info", with: @endpoint_device.contact_info
    fill_in "Description", with: @endpoint_device.description
    fill_in "Gps position", with: @endpoint_device.gps_position
    fill_in "Ip address", with: @endpoint_device.ip_address
    fill_in "Network", with: @endpoint_device.network_id
    fill_in "Title", with: @endpoint_device.title
    click_on "Create Endpoint device"

    assert_text "Endpoint device was successfully created"
    click_on "Back"
  end

  test "should update Endpoint device" do
    visit endpoint_device_url(@endpoint_device)
    click_on "Edit this endpoint device", match: :first

    fill_in "Contact info", with: @endpoint_device.contact_info
    fill_in "Description", with: @endpoint_device.description
    fill_in "Gps position", with: @endpoint_device.gps_position
    fill_in "Ip address", with: @endpoint_device.ip_address
    fill_in "Network", with: @endpoint_device.network_id
    fill_in "Title", with: @endpoint_device.title
    click_on "Update Endpoint device"

    assert_text "Endpoint device was successfully updated"
    click_on "Back"
  end

  test "should destroy Endpoint device" do
    visit endpoint_device_url(@endpoint_device)
    click_on "Destroy this endpoint device", match: :first

    assert_text "Endpoint device was successfully destroyed"
  end
end
