class CurrentStatesController < ApplicationController
  before_action :set_current_state, only: %i[ show edit update destroy ]

  # GET /current_states or /current_states.json
  def index
    @current_states = CurrentState.all
  end

  # GET /current_states/1 or /current_states/1.json
  def show
  end

  # GET /current_states/new
  def new
    @current_state = CurrentState.new
  end

  # GET /current_states/1/edit
  def edit
  end

  # POST /current_states or /current_states.json
  def create
    @current_state = CurrentState.new(current_state_params)

    respond_to do |format|
      if @current_state.save
        format.html { redirect_to current_state_url(@current_state), notice: "Current state was successfully created." }
        format.json { render :show, status: :created, location: @current_state }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @current_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /current_states/1 or /current_states/1.json
  def update
    respond_to do |format|
      if @current_state.update(current_state_params)
        format.html { redirect_to current_state_url(@current_state), notice: "Current state was successfully updated." }
        format.json { render :show, status: :ok, location: @current_state }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @current_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_states/1 or /current_states/1.json
  def destroy
    @current_state.destroy

    respond_to do |format|
      format.html { redirect_to current_states_url, notice: "Current state was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_state
      @current_state = CurrentState.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def current_state_params
      params.require(:current_state).permit(:state, :smart_plug_device_id, :network_id)
    end
end
