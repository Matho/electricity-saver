class NetworksController < ApplicationController
  before_action :set_network, only: %i[ show edit update destroy ]

  def index
    @networks = Network.page(params[:page])
  end

  def show
  end

  def new
    @network = Network.new
  end

  def edit
  end

  def create
    @network = Network.new(network_params)

    respond_to do |format|
      if @network.save
        format.html { redirect_to network_url(@network), notice: "Network was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @network.update(network_params)
        format.html { redirect_to network_url(@network), notice: "Network was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @network.destroy

    respond_to do |format|
      format.html { redirect_to networks_url, notice: "Network was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network
      @network = Network.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def network_params
      params.require(:network).permit(:title, :description, :active)
    end
end
