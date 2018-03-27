class SoftwareController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]

  # GET /software
  # GET /software.json
  def index
    @software = Software.all
  end

  # GET /software/1
  # GET /software/1.json
  def show
  end

  # GET /software/new
  def new
    @software = Software.new
  end

  # GET /software/1/edit
  def edit
  end

  # POST /software
  # POST /software.json
  def create
    @software = Software.new(software_params)

    respond_to do |format|
      if @software.save
        format.html { redirect_to @software, notice: 'Software was successfully created.' }
        format.json { render :show, status: :created, location: @software }
      else
        format.html { render :new }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /software/1
  # PATCH/PUT /software/1.json
  def update
    respond_to do |format|
      if @software.update(software_params)
        format.html { redirect_to @software, notice: 'Software was successfully updated.' }
        format.json { render :show, status: :ok, location: @software }
      else
        format.html { render :edit }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /software/1
  # DELETE /software/1.json
  def destroy
    @software.destroy
    respond_to do |format|
      format.html { redirect_to software_index_url, notice: 'Software was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software
      @software = Software.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def software_params
      params.fetch(:software, {})
    end
end
