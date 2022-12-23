require "test_helper"

class SmartPlugDevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @smart_plug_device = smart_plug_devices(:one)
  end

  test "should get index" do
    get smart_plug_devices_url
    assert_response :success
  end

  test "should get new" do
    get new_smart_plug_device_url
    assert_response :success
  end

  test "should create smart_plug_device" do
    assert_difference("SmartPlugDevice.count") do
      post smart_plug_devices_url, params: { smart_plug_device: { api_title: @smart_plug_device.api_title, current_state: @smart_plug_device.current_state, description: @smart_plug_device.description, ip_address: @smart_plug_device.ip_address, network_id: @smart_plug_device.network_id, title: @smart_plug_device.title } }
    end

    assert_redirected_to smart_plug_device_url(SmartPlugDevice.last)
  end

  test "should show smart_plug_device" do
    get smart_plug_device_url(@smart_plug_device)
    assert_response :success
  end

  test "should get edit" do
    get edit_smart_plug_device_url(@smart_plug_device)
    assert_response :success
  end

  test "should update smart_plug_device" do
    patch smart_plug_device_url(@smart_plug_device), params: { smart_plug_device: { api_title: @smart_plug_device.api_title, current_state: @smart_plug_device.current_state, description: @smart_plug_device.description, ip_address: @smart_plug_device.ip_address, network_id: @smart_plug_device.network_id, title: @smart_plug_device.title } }
    assert_redirected_to smart_plug_device_url(@smart_plug_device)
  end

  test "should destroy smart_plug_device" do
    assert_difference("SmartPlugDevice.count", -1) do
      delete smart_plug_device_url(@smart_plug_device)
    end

    assert_redirected_to smart_plug_devices_url
  end
end
