require "test_helper"

class PingStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ping_stat = ping_stats(:one)
  end

  test "should get index" do
    get ping_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_ping_stat_url
    assert_response :success
  end

  test "should create ping_stat" do
    assert_difference("PingStat.count") do
      post ping_stats_url, params: { ping_stat: { ip_addresss: @ping_stat.ip_addresss, response_code: @ping_stat.response_code, response_status: @ping_stat.response_status, response_time: @ping_stat.response_time } }
    end

    assert_redirected_to ping_stat_url(PingStat.last)
  end

  test "should show ping_stat" do
    get ping_stat_url(@ping_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_ping_stat_url(@ping_stat)
    assert_response :success
  end

  test "should update ping_stat" do
    patch ping_stat_url(@ping_stat), params: { ping_stat: { ip_addresss: @ping_stat.ip_addresss, response_code: @ping_stat.response_code, response_status: @ping_stat.response_status, response_time: @ping_stat.response_time } }
    assert_redirected_to ping_stat_url(@ping_stat)
  end

  test "should destroy ping_stat" do
    assert_difference("PingStat.count", -1) do
      delete ping_stat_url(@ping_stat)
    end

    assert_redirected_to ping_stats_url
  end
end
