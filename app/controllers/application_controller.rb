class ApplicationController < ActionController::Base
  add_flash_types :info, :error

  before_action :authenticate_user!
  before_action :set_network, only: %i[ index new create show edit update destroy ]

  def choose_network
    @networks = Network.all.order(:id)
  end

  protected

  def redirect_to_choose_network
    redirect_to root_path if @current_network.blank?
  end

  private
  def set_network
    @current_network = Network.find_by(id: params[:network_id])
  end
end
