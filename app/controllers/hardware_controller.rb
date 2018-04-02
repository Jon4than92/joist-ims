class HardwareController < ApplicationController
  before_action :set_hardware, only: [:show, :edit, :update, :destroy]

  # GET /hardware
  # GET /hardware.json
  def index
    @hardware = Hardware.all
  end

  # GET /hardware/1
  # GET /hardware/1.json
  def show
  end

  # GET /hardware/new
  def new
    @hardware = Hardware.new
  end

  # GET /hardware/1/edit
  def edit
  end

  # POST /hardware
  # POST /hardware.json
  def create
    @hardware = Hardware.new(permitted_params[:hardware])
    params[:hardware]

    respond_to do |format|
      if @hardware.save
        format.html { redirect_to @hardware, notice: 'Hardware was successfully created.' }
        format.json { render :show, status: :created, location: @hardware }
      else
        format.html { render :new }
        format.json { render json: @hardware.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hardware/1
  # PATCH/PUT /hardware/1.json
  def update
    respond_to do |format|
      if @hardware.update(hardware_params)
        format.html { redirect_to @hardware, notice: 'Hardware was successfully updated.' }
        format.json { render :show, status: :ok, location: @hardware }
      else
        format.html { render :edit }
        format.json { render json: @hardware.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hardware/1
  # DELETE /hardware/1.json
  def destroy
    @hardware.destroy
    respond_to do |format|
      format.html { redirect_to hardware_index_url, notice: 'Hardware was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hardware
      @hardware = Hardware.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hardware_params
      params.fetch(:hardware, {})
    end
end
