class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :valid_check, only: [:index, :new, :show, :create, :destroy, :update]

  # GET /topics
  # GET /topics.json
  def index
    @topic_id = params[:topic_id]
      if @topic_id != nil
        @topic_id_name = Topic.find(@topic_id)

        # @user_groups = Topic.forum_groups(current_user.id)

        # access_check.push(@topic_id_name.group_type.to_f)
        # access_check = Topic.parent_group_check(@topic_id)

        # Rails.logger.info "Access Check: " + access_check.to_s
        @access = Topic.parent_group_access(@topic_id, current_user.id)

        # Moved to Topic.parent_group_access

        # @access = true
        # # Rails.logger.info "User Check:" + @user_groups.to_s
        #   access_check.each do |x|
        #     a = @user_groups.include?(x)
        #     # Rails.logger.info "Permission check: " + x.to_s + " | " + a.to_s
        #     if a == false
        #       @access = a
        #     end
        #   end


         # Rails.logger.info "Permission? " + @access.to_s + " | Admin: " + current_user.admin.to_s + " | " + @topic_id_name.group_required.to_s
        if @access == false && current_user.admin == false
          Rails.logger.info "======================"
          Rails.logger.info "Redirect_to Forum Root"
          Rails.logger.info "======================"
          redirect_to topics_url
        end
      end

    @topics = Topic.where('topic_id' => @topic_id).order(rank: :desc)
    @topic = Topic.new

    @posts = Post.where('topic_id' => @topic_id).paginate(:page => params[:page], :per_page => 10).order(created_at: :asc)
    @post = Post.new

    @groups = Group.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
    @groups = Group.all

  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_url, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topics_url, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    child_topics = Topic.where('topic_id' => @topic.id)
      if child_topics.blank? == true
        @topic.destroy
        respond_to do |format|
          format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
          format.json { head :no_content }
        end
      else
        redirect_to topics_url, notice: 'Existing sub-topics, Delete denied'
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:user_id, :topic_id, :title, :description, :group_required, :group_type, :allow_posts, :allow_topics, :rank)
    end
end
