class EndpointDevicesController < ApplicationController
  before_action :set_endpoint_device, only: %i[ show edit update destroy ]

  # GET /endpoint_devices or /endpoint_devices.json
  def index
    @endpoint_devices = EndpointDevice.all
  end

  # GET /endpoint_devices/1 or /endpoint_devices/1.json
  def show
  end

  # GET /endpoint_devices/new
  def new
    @endpoint_device = EndpointDevice.new
  end

  # GET /endpoint_devices/1/edit
  def edit
  end

  # POST /endpoint_devices or /endpoint_devices.json
  def create
    @endpoint_device = EndpointDevice.new(endpoint_device_params)

    respond_to do |format|
      if @endpoint_device.save
        format.html { redirect_to endpoint_device_url(@endpoint_device), notice: "Endpoint device was successfully created." }
        format.json { render :show, status: :created, location: @endpoint_device }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @endpoint_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endpoint_devices/1 or /endpoint_devices/1.json
  def update
    respond_to do |format|
      if @endpoint_device.update(endpoint_device_params)
        format.html { redirect_to endpoint_device_url(@endpoint_device), notice: "Endpoint device was successfully updated." }
        format.json { render :show, status: :ok, location: @endpoint_device }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @endpoint_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endpoint_devices/1 or /endpoint_devices/1.json
  def destroy
    @endpoint_device.destroy

    respond_to do |format|
      format.html { redirect_to endpoint_devices_url, notice: "Endpoint device was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint_device
      @endpoint_device = EndpointDevice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def endpoint_device_params
      params.require(:endpoint_device).permit(:title, :gps_position, :description, :ip_address, :contact_info, :network_id)
    end
end
