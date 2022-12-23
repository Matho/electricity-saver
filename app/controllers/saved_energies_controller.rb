class SavedEnergiesController < ApplicationController
  before_action :set_saved_energy, only: %i[ show edit update destroy ]

  # GET /saved_energies or /saved_energies.json
  def index
    @saved_energies = SavedEnergy.all
  end

  # GET /saved_energies/1 or /saved_energies/1.json
  def show
  end

  # GET /saved_energies/new
  def new
    @saved_energy = SavedEnergy.new
  end

  # GET /saved_energies/1/edit
  def edit
  end

  # POST /saved_energies or /saved_energies.json
  def create
    @saved_energy = SavedEnergy.new(saved_energy_params)

    respond_to do |format|
      if @saved_energy.save
        format.html { redirect_to saved_energy_url(@saved_energy), notice: "Saved energy was successfully created." }
        format.json { render :show, status: :created, location: @saved_energy }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @saved_energy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saved_energies/1 or /saved_energies/1.json
  def update
    respond_to do |format|
      if @saved_energy.update(saved_energy_params)
        format.html { redirect_to saved_energy_url(@saved_energy), notice: "Saved energy was successfully updated." }
        format.json { render :show, status: :ok, location: @saved_energy }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @saved_energy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_energies/1 or /saved_energies/1.json
  def destroy
    @saved_energy.destroy

    respond_to do |format|
      format.html { redirect_to saved_energies_url, notice: "Saved energy was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saved_energy
      @saved_energy = SavedEnergy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def saved_energy_params
      params.require(:saved_energy).permit(:smart_plug_device_id, :savings, :network_id)
    end
end
