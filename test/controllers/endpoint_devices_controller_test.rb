require "test_helper"

class EndpointDevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @endpoint_device = endpoint_devices(:one)
  end

  test "should get index" do
    get endpoint_devices_url
    assert_response :success
  end

  test "should get new" do
    get new_endpoint_device_url
    assert_response :success
  end

  test "should create endpoint_device" do
    assert_difference("EndpointDevice.count") do
      post endpoint_devices_url, params: { endpoint_device: { contact_info: @endpoint_device.contact_info, description: @endpoint_device.description, gps_position: @endpoint_device.gps_position, ip_address: @endpoint_device.ip_address, network_id: @endpoint_device.network_id, title: @endpoint_device.title } }
    end

    assert_redirected_to endpoint_device_url(EndpointDevice.last)
  end

  test "should show endpoint_device" do
    get endpoint_device_url(@endpoint_device)
    assert_response :success
  end

  test "should get edit" do
    get edit_endpoint_device_url(@endpoint_device)
    assert_response :success
  end

  test "should update endpoint_device" do
    patch endpoint_device_url(@endpoint_device), params: { endpoint_device: { contact_info: @endpoint_device.contact_info, description: @endpoint_device.description, gps_position: @endpoint_device.gps_position, ip_address: @endpoint_device.ip_address, network_id: @endpoint_device.network_id, title: @endpoint_device.title } }
    assert_redirected_to endpoint_device_url(@endpoint_device)
  end

  test "should destroy endpoint_device" do
    assert_difference("EndpointDevice.count", -1) do
      delete endpoint_device_url(@endpoint_device)
    end

    assert_redirected_to endpoint_devices_url
  end
end
