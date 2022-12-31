class EndpointDevicesController < ApplicationController
  before_action :set_endpoint_device, only: %i[ show edit update destroy ]

  def index
    @endpoint_devices = @current_network.endpoint_devices.page(params[:page]).order(id: :desc)
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

  def destroy
    destroyed = @endpoint_device.destroy

    if destroyed
      hash = {
        notice: "Endpoint device was successfully destroyed."
      }
    else
      hash = {
        error: "Endpoint device was not destroyed."
      }
    end

    respond_to do |format|
      format.html { redirect_to network_endpoint_devices_path(@current_network), hash  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint_device
      @endpoint_device = @current_network.endpoint_devices.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def endpoint_device_params
      params.require(:endpoint_device).permit(:title, :gps_position, :description, :ip_address, :contact_info, :network_id, :active_monitoring, :needs_to_be_available)
    end
end
