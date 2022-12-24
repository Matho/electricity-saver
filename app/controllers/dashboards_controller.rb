class DashboardsController < ApplicationController
  before_action :redirect_to_choose_network, only: %i[ index ]

  def index
    @uptime_stats = @current_network.uptime_stats.includes(:endpoint_device).last_sorted
    @saved_energies = @current_network.saved_energies.includes(:smart_plug_device).last_sorted
    @smart_plug_devices = @current_network.smart_plug_devices
    @event_logs = @current_network.event_logs.includes(:endpoint_device).last_sorted
    @ping_stats = @current_network.ping_stats.last_sorted
  end
end
