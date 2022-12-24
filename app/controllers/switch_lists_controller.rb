class SwitchListsController < ApplicationController
  before_action :redirect_to_choose_network, only: %i[ index ]

  def index
    @smart_plug_devices = @current_network.smart_plug_devices
  end
end
