class DashboardsController < ApplicationController
  before_action :redirect_to_choose_network, only: %i[ index ]

  def index
  end
end
