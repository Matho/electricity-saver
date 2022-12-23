class SmartPlugDevicesController < ApplicationController
  before_action :set_smart_plug_device, only: %i[ show edit update destroy ]

  # GET /smart_plug_devices or /smart_plug_devices.json
  def index
    @smart_plug_devices = SmartPlugDevice.all
  end

  # GET /smart_plug_devices/1 or /smart_plug_devices/1.json
  def show
  end

  # GET /smart_plug_devices/new
  def new
    @smart_plug_device = SmartPlugDevice.new
  end

  # GET /smart_plug_devices/1/edit
  def edit
  end

  # POST /smart_plug_devices or /smart_plug_devices.json
  def create
    @smart_plug_device = SmartPlugDevice.new(smart_plug_device_params)

    respond_to do |format|
      if @smart_plug_device.save
        format.html { redirect_to smart_plug_device_url(@smart_plug_device), notice: "Smart plug device was successfully created." }
        format.json { render :show, status: :created, location: @smart_plug_device }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @smart_plug_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /smart_plug_devices/1 or /smart_plug_devices/1.json
  def update
    respond_to do |format|
      if @smart_plug_device.update(smart_plug_device_params)
        format.html { redirect_to smart_plug_device_url(@smart_plug_device), notice: "Smart plug device was successfully updated." }
        format.json { render :show, status: :ok, location: @smart_plug_device }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @smart_plug_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /smart_plug_devices/1 or /smart_plug_devices/1.json
  def destroy
    @smart_plug_device.destroy

    respond_to do |format|
      format.html { redirect_to smart_plug_devices_url, notice: "Smart plug device was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_smart_plug_device
      @smart_plug_device = SmartPlugDevice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def smart_plug_device_params
      params.require(:smart_plug_device).permit(:title, :description, :api_title, :current_state, :ip_address, :network_id)
    end
end
