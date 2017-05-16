class GroupsController < ApplicationController
  before_action :admin_check, only: [:index, :show, :create, :update, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :clear_members, only: [:destroy]
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all.order("id ASC")
    @group = Group.new
    @members = Membership.new
    @approvals = Membership.where('approved' => false).order("id DESC").limit(5)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @members = Membership.new
    @memberships = Membership.where('group_id' => params[:id]).paginate(:page => params[:page], :per_page => 25).order(id: :desc)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to :back, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    def clear_members
      Membership.where(group_id: params[:id]).destroy_all
      Rails.logger.info "Clear All Members - " + params[:id]

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:id, :name, :is_admin, :category, :note, :chat_group_name, :is_chat_group, :is_hidden)
    end
end
