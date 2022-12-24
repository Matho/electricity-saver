class EndpointDevicesController < ApplicationController
  before_action :set_network, only: %i[ index new create show edit update destroy ]
  before_action :redirect_to_choose_network, only: %i[ index ]
  before_action :set_endpoint_device, only: %i[ show edit update destroy ]

  def index
    @endpoint_devices = @current_network.endpoint_devices.page(params[:page])
  end

  def show
  end

  def new
    @endpoint_device = @current_network.endpoint_devices.new
  end

  def edit
  end

  def create
    @endpoint_device = @current_network.endpoint_devices.new(endpoint_device_params)

    respond_to do |format|
      if @endpoint_device.save
        format.html { redirect_to network_endpoint_device_path(@current_network, @endpoint_device), notice: "Endpoint device was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @endpoint_device.update(endpoint_device_params)
        format.html { redirect_to network_endpoint_device_path(@current_network, @endpoint_device), notice: "Endpoint device was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endpoint_devices/1 or /endpoint_devices/1.json
  def destroy
    @endpoint_device.destroy

    respond_to do |format|
      format.html { redirect_to network_endpoint_devices_path(@current_network), notice: "Endpoint device was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint_device
      @endpoint_device = @current_network.endpoint_devices.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def endpoint_device_params
      params.require(:endpoint_device).permit(:title, :gps_position, :description, :ip_address, :contact_info, :network_id)
    end
end
