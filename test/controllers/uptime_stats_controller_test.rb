require "test_helper"

class UptimeStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uptime_stat = uptime_stats(:one)
  end

  test "should get index" do
    get uptime_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_uptime_stat_url
    assert_response :success
  end

  test "should create uptime_stat" do
    assert_difference("UptimeStat.count") do
      post uptime_stats_url, params: { uptime_stat: { available: @uptime_stat.available, check_date: @uptime_stat.check_date, endpoint_device_id: @uptime_stat.endpoint_device_id, network_id: @uptime_stat.network_id } }
    end

    assert_redirected_to uptime_stat_url(UptimeStat.last)
  end

  test "should show uptime_stat" do
    get uptime_stat_url(@uptime_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_uptime_stat_url(@uptime_stat)
    assert_response :success
  end

  test "should update uptime_stat" do
    patch uptime_stat_url(@uptime_stat), params: { uptime_stat: { available: @uptime_stat.available, check_date: @uptime_stat.check_date, endpoint_device_id: @uptime_stat.endpoint_device_id, network_id: @uptime_stat.network_id } }
    assert_redirected_to uptime_stat_url(@uptime_stat)
  end

  test "should destroy uptime_stat" do
    assert_difference("UptimeStat.count", -1) do
      delete uptime_stat_url(@uptime_stat)
    end

    assert_redirected_to uptime_stats_url
  end
end
