class SrpRequestsController < ApplicationController
  before_action :director_check, only: [:admin_index_all, :admin_index_pending, :admin_index_flagged, :destroy]
  before_action :valid_check
  before_action :set_srp_request, only: [:show, :edit, :update, :destroy]
  before_action :set_pages

  # GET /srp_requests
  # GET /srp_requests.json
  def index
    @srp_request = SrpRequest.new
    @my_srp_requests = SrpRequest.where('user_id' => current_user)
  end

  def admin_index_all
    @srp_requests = SrpRequest.all.paginate(:page => params[:page], :per_page => @pages).order(updated_at: :desc)
  end

  def admin_index_pending
    @srp_requests = SrpRequest.where('status' => 0).paginate(:page => params[:page], :per_page => @pages)
  end

  def admin_index_flagged
    @srp_requests = SrpRequest.where('status' => 2).paginate(:page => params[:page], :per_page => @pages)
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

  # POST /srp_requests
  # POST /srp_requests.json
  def create
      Rails.logger.info srp_request_params

    respond_to do |format|
      Rails.logger.info '======================'
      Rails.logger.info 'URI Check - Start'
      Rails.logger.info '======================'
      Rails.logger.info "params: " + srp_request_params[:link].to_s

      begin
        uri = URI(srp_request_params[:link])
        Rails.logger.info "URL Test - " + uri.to_s + ' | ' + uri.host.to_s
        if uri.host.to_s == 'zkillboard.com'
          url_check = true
        else
          url_check = false
        end

        duplicate_check = SrpRequest.exists?('link' => srp_request_params[:link].to_s)
        Rails.logger.info 'duplicate_check: ' + duplicate_check.to_s
        if duplicate_check == true
          url_check = false
        end

      rescue
        url_check = false
        Rails.logger.info "failed URL check"
        format.html { redirect_to srp_requests_path, notice: 'Error creating request. - Bad link' }
      end

      if url_check == true
        @srp_request = SrpRequest.new(srp_request_params)
        if @srp_request.save  
          format.html { redirect_to @srp_request, notice: 'Srp request was successfully created.' }
          format.json { render :show, status: :created, location: @srp_request }
        else
          format.html { render :new }
          format.json { render json: @srp_request.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to srp_requests_path, notice: 'Error creating request. - Invalid site or Duplicate' }
      end
      Rails.logger.info '======================'
      Rails.logger.info 'URI Check - Finish'
      Rails.logger.info '======================'
    end
  end

  # PATCH/PUT /srp_requests/1
  # PATCH/PUT /srp_requests/1.json
  def update
    respond_to do |format|
      Rails.logger.info 'Update - ' + @srp_request.to_s
      if @srp_request.status == 0
        Rails.logger.info "Generate payment_id"
        @srp_request.payment_id = $server_id + @srp_request.id
      end
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

    def set_pages
      @pages = 25
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def srp_request_params
      params.require(:srp_request).permit(:link, :user_id, :user_name, :ship, :user_notes, :status, :payment_id, :SRP_amount, :admin_notes)
    end
  end
