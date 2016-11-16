class SrpRequestsController < ApplicationController
  before_action :set_srp_request, only: [:show, :edit, :update, :destroy]

  # GET /srp_requests
  # GET /srp_requests.json
  def index
    @srp_request = SrpRequest.new
    @my_srp_requests = SrpRequest.where('user_id' => current_user)
  end

  def admin_index_all
    @srp_requests = SrpRequest.all
  end

  def admin_index_pending
    @srp_requests = SrpRequest.where('status' => 0)
  end

  def admin_index_flagged
    @srp_requests = SrpRequest.where('status' => 2)
  end

  # GET /srp_requests/1
  # GET /srp_requests/1.json
  def show
  end

  # GET /srp_requests/new
  def new
    @srp_request = SrpRequest.new
  end

  # GET /srp_requests/1/edit
  def edit
  end

  def SRPaction
    Rails.logger.info "SRP Controller Action "
    # redirect_to @srp_request
  end

  # POST /srp_requests
  # POST /srp_requests.json
  def create
    # check link field is real url
    # /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/
    @srp_request = SrpRequest.new(srp_request_params)

    respond_to do |format|
      if @srp_request.save
        format.html { redirect_to @srp_request, notice: 'Srp request was successfully created.' }
        format.json { render :show, status: :created, location: @srp_request }
      else
        format.html { render :new }
        format.json { render json: @srp_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /srp_requests/1
  # PATCH/PUT /srp_requests/1.json
  def update
    respond_to do |format|
      if @srp_request.update(srp_request_params)
        format.html { redirect_to @srp_request, notice: 'Srp request was successfully updated.' }
        format.json { render :show, status: :ok, location: @srp_request }
      else
        format.html { render :edit }
        format.json { render json: @srp_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /srp_requests/1
  # DELETE /srp_requests/1.json
  def destroy
    @srp_request.destroy
    respond_to do |format|
      format.html { redirect_to srp_requests_url, notice: 'Srp request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_srp_request
      @srp_request = SrpRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def srp_request_params
      params.require(:srp_request).permit(:link, :user_id, :user_name, :ship, :user_notes, :status, :payment_id, :SRP_amount, :admin_notes)
    end
end
