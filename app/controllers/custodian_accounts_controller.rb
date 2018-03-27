class CustodianAccountsController < ApplicationController
  before_action :set_custodian_account, only: [:show, :edit, :update, :destroy]

  # GET /custodian_accounts
  # GET /custodian_accounts.json
  def index
    @custodian_accounts = CustodianAccount.all
  end

  # GET /custodian_accounts/1
  # GET /custodian_accounts/1.json
  def show
  end

  # GET /custodian_accounts/new
  def new
    @custodian_account = CustodianAccount.new
  end

  # GET /custodian_accounts/1/edit
  def edit
  end

  # POST /custodian_accounts
  # POST /custodian_accounts.json
  def create
    @custodian_account = CustodianAccount.new(custodian_account_params)

    respond_to do |format|
      if @custodian_account.save
        format.html { redirect_to @custodian_account, notice: 'Custodian account was successfully created.' }
        format.json { render :show, status: :created, location: @custodian_account }
      else
        format.html { render :new }
        format.json { render json: @custodian_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custodian_accounts/1
  # PATCH/PUT /custodian_accounts/1.json
  def update
    respond_to do |format|
      if @custodian_account.update(custodian_account_params)
        format.html { redirect_to @custodian_account, notice: 'Custodian account was successfully updated.' }
        format.json { render :show, status: :ok, location: @custodian_account }
      else
        format.html { render :edit }
        format.json { render json: @custodian_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custodian_accounts/1
  # DELETE /custodian_accounts/1.json
  def destroy
    @custodian_account.destroy
    respond_to do |format|
      format.html { redirect_to custodian_accounts_url, notice: 'Custodian account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custodian_account
      @custodian_account = CustodianAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custodian_account_params
      params.fetch(:custodian_account, {})
    end
end
