class SavedEnergiesController < ApplicationController
  before_action :set_saved_energy, only: %i[ destroy ]

  def index
    @saved_energies = @current_network.saved_energies.includes(:smart_plug_device).page(params[:page]).order('id desc')
  end

  def destroy
    @saved_energy.destroy

    respond_to do |format|
      format.html { redirect_to network_saved_energies_url(@current_network), notice: "Saved energy was successfully destroyed." }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_saved_energy
    @saved_energy = @current_network.saved_energies.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def saved_energy_params
    params.require(:saved_energy).permit(:smart_plug_device_id, :savings, :network_id)
  end
end
