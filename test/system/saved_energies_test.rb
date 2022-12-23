require "application_system_test_case"

class SavedEnergiesTest < ApplicationSystemTestCase
  setup do
    @saved_energy = saved_energies(:one)
  end

  test "visiting the index" do
    visit saved_energies_url
    assert_selector "h1", text: "Saved energies"
  end

  test "should create saved energy" do
    visit saved_energies_url
    click_on "New saved energy"

    fill_in "Network", with: @saved_energy.network_id
    fill_in "Savings", with: @saved_energy.savings
    fill_in "Smart plug device", with: @saved_energy.smart_plug_device_id
    click_on "Create Saved energy"

    assert_text "Saved energy was successfully created"
    click_on "Back"
  end

  test "should update Saved energy" do
    visit saved_energy_url(@saved_energy)
    click_on "Edit this saved energy", match: :first

    fill_in "Network", with: @saved_energy.network_id
    fill_in "Savings", with: @saved_energy.savings
    fill_in "Smart plug device", with: @saved_energy.smart_plug_device_id
    click_on "Update Saved energy"

    assert_text "Saved energy was successfully updated"
    click_on "Back"
  end

  test "should destroy Saved energy" do
    visit saved_energy_url(@saved_energy)
    click_on "Destroy this saved energy", match: :first

    assert_text "Saved energy was successfully destroyed"
  end
end
