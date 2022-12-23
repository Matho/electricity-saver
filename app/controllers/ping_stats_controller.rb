class PingStatsController < ApplicationController
  before_action :set_ping_stat, only: %i[ show edit update destroy ]

  # GET /ping_stats or /ping_stats.json
  def index
    @ping_stats = PingStat.all
  end

  # GET /ping_stats/1 or /ping_stats/1.json
  def show
  end

  # GET /ping_stats/new
  def new
    @ping_stat = PingStat.new
  end

  # GET /ping_stats/1/edit
  def edit
  end

  # POST /ping_stats or /ping_stats.json
  def create
    @ping_stat = PingStat.new(ping_stat_params)

    respond_to do |format|
      if @ping_stat.save
        format.html { redirect_to ping_stat_url(@ping_stat), notice: "Ping stat was successfully created." }
        format.json { render :show, status: :created, location: @ping_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ping_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ping_stats/1 or /ping_stats/1.json
  def update
    respond_to do |format|
      if @ping_stat.update(ping_stat_params)
        format.html { redirect_to ping_stat_url(@ping_stat), notice: "Ping stat was successfully updated." }
        format.json { render :show, status: :ok, location: @ping_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ping_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ping_stats/1 or /ping_stats/1.json
  def destroy
    @ping_stat.destroy

    respond_to do |format|
      format.html { redirect_to ping_stats_url, notice: "Ping stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ping_stat
      @ping_stat = PingStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ping_stat_params
      params.require(:ping_stat).permit(:ip_addresss, :response_time, :response_code, :response_status)
    end
end
