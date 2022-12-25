class CurrentStatesController < ApplicationController

  def index
    @current_states = @current_network.current_states.includes(:smart_plug_device).page(params[:page]).order('id desc')
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_current_state
    @current_state = @current_network.current_states.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def current_state_params
    params.require(:current_state).permit(:state, :smart_plug_device_id, :network_id)
  end
end
