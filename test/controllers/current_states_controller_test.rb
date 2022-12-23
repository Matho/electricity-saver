require "test_helper"

class CurrentStatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_state = current_states(:one)
  end

  test "should get index" do
    get current_states_url
    assert_response :success
  end

  test "should get new" do
    get new_current_state_url
    assert_response :success
  end

  test "should create current_state" do
    assert_difference("CurrentState.count") do
      post current_states_url, params: { current_state: { network_id: @current_state.network_id, smart_plug_device_id: @current_state.smart_plug_device_id, state: @current_state.state } }
    end

    assert_redirected_to current_state_url(CurrentState.last)
  end

  test "should show current_state" do
    get current_state_url(@current_state)
    assert_response :success
  end

  test "should get edit" do
    get edit_current_state_url(@current_state)
    assert_response :success
  end

  test "should update current_state" do
    patch current_state_url(@current_state), params: { current_state: { network_id: @current_state.network_id, smart_plug_device_id: @current_state.smart_plug_device_id, state: @current_state.state } }
    assert_redirected_to current_state_url(@current_state)
  end

  test "should destroy current_state" do
    assert_difference("CurrentState.count", -1) do
      delete current_state_url(@current_state)
    end

    assert_redirected_to current_states_url
  end
end
