class SmartPlugDevicesController < ApplicationController
  before_action :set_network
  before_action :set_smart_plug_device, only: %i[ show edit update destroy ]

  def index
    @smart_plug_devices = @current_network.smart_plug_devices.page(params[:page]).order('id desc')
  end

  def show
  end

  def new
    @smart_plug_device = @current_network.smart_plug_devices.new
  end

  def edit
  end

  def create
    @smart_plug_device = @current_network.smart_plug_devices.new(smart_plug_device_params)

    respond_to do |format|
      if @smart_plug_device.save
        format.html { redirect_to network_smart_plug_device_path(@current_network, @smart_plug_device), notice: "Smart plug device was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @smart_plug_device.update(smart_plug_device_params)
        format.html { redirect_to network_smart_plug_device_path(@current_network, @smart_plug_device), notice: "Smart plug device was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    destroyed = @smart_plug_device.destroy

    if destroyed
      hash = {
        notice: "Smart plug device was successfully destroyed."
      }
    else
      hash = {
        error: "Smart plug device was not destroyed."
      }
    end

    respond_to do |format|
      format.html { redirect_to network_smart_plug_devices_path(@current_network), hash }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_smart_plug_device
    @smart_plug_device = @current_network.smart_plug_devices.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def smart_plug_device_params
    params.require(:smart_plug_device).permit(:title, :description, :api_title, :current_state, :api_status_url, :api_turn_on_url, :api_turn_off_url, :network_id, :energy_price_for_kwh, :avg_energy_consumption, :token, :off_timeout)
  end
end
