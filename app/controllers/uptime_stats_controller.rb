class UptimeStatsController < ApplicationController
  before_action :set_uptime_stat, only: %i[ show edit update destroy ]

  # GET /uptime_stats or /uptime_stats.json
  def index
    @uptime_stats = UptimeStat.all
  end

  # GET /uptime_stats/1 or /uptime_stats/1.json
  def show
  end

  # GET /uptime_stats/new
  def new
    @uptime_stat = UptimeStat.new
  end

  # GET /uptime_stats/1/edit
  def edit
  end

  # POST /uptime_stats or /uptime_stats.json
  def create
    @uptime_stat = UptimeStat.new(uptime_stat_params)

    respond_to do |format|
      if @uptime_stat.save
        format.html { redirect_to uptime_stat_url(@uptime_stat), notice: "Uptime stat was successfully created." }
        format.json { render :show, status: :created, location: @uptime_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @uptime_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uptime_stats/1 or /uptime_stats/1.json
  def update
    respond_to do |format|
      if @uptime_stat.update(uptime_stat_params)
        format.html { redirect_to uptime_stat_url(@uptime_stat), notice: "Uptime stat was successfully updated." }
        format.json { render :show, status: :ok, location: @uptime_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @uptime_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uptime_stats/1 or /uptime_stats/1.json
  def destroy
    @uptime_stat.destroy

    respond_to do |format|
      format.html { redirect_to uptime_stats_url, notice: "Uptime stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uptime_stat
      @uptime_stat = UptimeStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def uptime_stat_params
      params.require(:uptime_stat).permit(:endpoint_device_id, :available, :check_date, :network_id)
    end
end
