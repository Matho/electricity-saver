class RulesController < ApplicationController
  before_action :set_network
  before_action :set_rule, only: %i[ show edit update destroy ]

  def index
    @rules = @current_network.rules.includes(:smart_plug_device).page(params[:page]).order('id desc')
  end

  def show
  end

  def new
    @rule = @current_network.rules.new
  end

  def edit
  end

  def create
    @rule = @current_network.rules.new(rule_params)

    respond_to do |format|
      if @rule.save
        format.html { redirect_to network_rule_path(@current_network, @rule), notice: "Rule was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to network_rule_path(@current_network, @rule), notice: "Rule was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to network_rules_path(@current_network), notice: "Rule was successfully destroyed." }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = @current_network.rules.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def rule_params
    params.require(:rule).permit(:rule, :smart_plug_device_id, :action, :cron_monday, :cron_tuesday, :cron_wednesday, :cron_thursday, :cron_friday,  :cron_saturday,  :cron_sunday)
  end
end
