class SwitchListsController < ApplicationController
  before_action :redirect_to_choose_network, only: %i[ index ]

  def index
    @smart_plug_devices = @current_network.smart_plug_devices
    @uptime_stats = @current_network.uptime_stats.includes(:endpoint_device).last_sorted
    @event_logs = @current_network.event_logs.includes(:event_loggable).last_sorted
    @scheduled_events = @current_network.scheduled_events.includes(:smart_plug_device).page(params[:page]).order(event_date: :desc)
  end
end
