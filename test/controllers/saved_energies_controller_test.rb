require "test_helper"

class SavedEnergiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saved_energy = saved_energies(:one)
  end

  test "should get index" do
    get saved_energies_url
    assert_response :success
  end

  test "should get new" do
    get new_saved_energy_url
    assert_response :success
  end

  test "should create saved_energy" do
    assert_difference("SavedEnergy.count") do
      post saved_energies_url, params: { saved_energy: { network_id: @saved_energy.network_id, savings: @saved_energy.savings, smart_plug_device_id: @saved_energy.smart_plug_device_id } }
    end

    assert_redirected_to saved_energy_url(SavedEnergy.last)
  end

  test "should show saved_energy" do
    get saved_energy_url(@saved_energy)
    assert_response :success
  end

  test "should get edit" do
    get edit_saved_energy_url(@saved_energy)
    assert_response :success
  end

  test "should update saved_energy" do
    patch saved_energy_url(@saved_energy), params: { saved_energy: { network_id: @saved_energy.network_id, savings: @saved_energy.savings, smart_plug_device_id: @saved_energy.smart_plug_device_id } }
    assert_redirected_to saved_energy_url(@saved_energy)
  end

  test "should destroy saved_energy" do
    assert_difference("SavedEnergy.count", -1) do
      delete saved_energy_url(@saved_energy)
    end

    assert_redirected_to saved_energies_url
  end
end
