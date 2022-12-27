class ScheduledEventsController < ApplicationController
  before_action :set_scheduled_event, only: %i[ destroy ]

  def index
    @scheduled_events = @current_network.scheduled_events.page(params[:page]).order(id: :desc)
  end

  def destroy
    @scheduled_event.destroy

    respond_to do |format|
      format.html { redirect_to network_scheduled_events_url(@current_network), notice: "Scheduled event was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduled_event
      @scheduled_event = @current_network.scheduled_events.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scheduled_event_params
      params.require(:scheduled_event).permit(:event_date, :smart_plug_device_id, :action)
    end
end
