require "application_system_test_case"

class CurrentStatesTest < ApplicationSystemTestCase
  setup do
    @current_state = current_states(:one)
  end

  test "visiting the index" do
    visit current_states_url
    assert_selector "h1", text: "Current states"
  end

  test "should create current state" do
    visit current_states_url
    click_on "New current state"

    fill_in "Network", with: @current_state.network_id
    fill_in "Smart plug device", with: @current_state.smart_plug_device_id
    fill_in "State", with: @current_state.state
    click_on "Create Current state"

    assert_text "Current state was successfully created"
    click_on "Back"
  end

  test "should update Current state" do
    visit current_state_url(@current_state)
    click_on "Edit this current state", match: :first

    fill_in "Network", with: @current_state.network_id
    fill_in "Smart plug device", with: @current_state.smart_plug_device_id
    fill_in "State", with: @current_state.state
    click_on "Update Current state"

    assert_text "Current state was successfully updated"
    click_on "Back"
  end

  test "should destroy Current state" do
    visit current_state_url(@current_state)
    click_on "Destroy this current state", match: :first

    assert_text "Current state was successfully destroyed"
  end
end
