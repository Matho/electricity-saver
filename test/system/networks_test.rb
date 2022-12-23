require "application_system_test_case"

class NetworksTest < ApplicationSystemTestCase
  setup do
    @network = networks(:one)
  end

  test "visiting the index" do
    visit networks_url
    assert_selector "h1", text: "Networks"
  end

  test "should create network" do
    visit networks_url
    click_on "New network"

    check "Active" if @network.active
    fill_in "Description", with: @network.description
    fill_in "Title", with: @network.title
    click_on "Create Network"

    assert_text "Network was successfully created"
    click_on "Back"
  end

  test "should update Network" do
    visit network_url(@network)
    click_on "Edit this network", match: :first

    check "Active" if @network.active
    fill_in "Description", with: @network.description
    fill_in "Title", with: @network.title
    click_on "Update Network"

    assert_text "Network was successfully updated"
    click_on "Back"
  end

  test "should destroy Network" do
    visit network_url(@network)
    click_on "Destroy this network", match: :first

    assert_text "Network was successfully destroyed"
  end
end
