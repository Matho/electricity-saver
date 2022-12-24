class DashboardsController < ApplicationController
  before_action :redirect_to_choose_network, only: %i[ index ]

  def index
    @uptime_stats = @current_network.uptime_stats.last_sorted
  end
end
