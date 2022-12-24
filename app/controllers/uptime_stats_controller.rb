class UptimeStatsController < ApplicationController
  before_action :set_uptime_stat, only: %i[ show destroy ]

  def index
    @uptime_stats = @current_network.uptime_stats.page(params[:page]).order('id desc')
  end

  def show
  end

  def destroy
    @uptime_stat.destroy

    respond_to do |format|
      format.html { redirect_to network_uptime_stats_url(@current_network), notice: "Uptime stat was successfully destroyed." }
    end
  end

  private
  def set_uptime_stat
    @uptime_stat = @current_network.uptime_stats.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def uptime_stat_params
    params.require(:uptime_stat).permit(:endpoint_device_id, :available, :check_date, :network_id)
  end
end
