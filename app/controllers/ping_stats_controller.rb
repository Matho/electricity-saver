class PingStatsController < ApplicationController
  before_action :set_ping_stat, only: %i[ show destroy ]

  def index
    @ping_stats = @current_network.ping_stats.page(params[:page]).order(id: :desc)
  end

  def destroy
    @ping_stat.destroy

    respond_to do |format|
      format.html { redirect_to network_ping_stats_url(@current_network), notice: "Ping stat was successfully destroyed." }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ping_stat
    @ping_stat = @current_network.ping_stats.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ping_stat_params
    params.require(:ping_stat).permit(:ip_address, :response_time, :response_code, :response_status)
  end
end
