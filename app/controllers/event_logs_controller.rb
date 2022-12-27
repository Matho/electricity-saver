class EventLogsController < ApplicationController
  before_action :set_event_log, only: %i[ destroy ]

  def index
    @event_logs = @current_network.event_logs.includes(:event_loggable).page(params[:page]).order(id: :desc)
  end

  def destroy
    @event_log.destroy

    respond_to do |format|
      format.html { redirect_to network_event_logs_url(@current_network), notice: "Event log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event_log
    @event_log = @current_network.event_logs.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_log_params
    params.require(:event_log).permit(:title, :event_date, :endpoint_device_id)
  end
end
