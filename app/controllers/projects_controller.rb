class ProjectsController < ApplicationController
  before_action :admin_user,     only: :index

  def index
    @projects = Project.all
  end

	def new
    @header = "Submit a New Project"
	  @project = Project.new
	end

	def create
    if user_signed_in?
  		@project = current_user.projects.build(project_params)
      @project.user_id = current_user.id

      respond_to do |format|
        if @project.save
          session.delete(:project_name)
          session.delete(:twitter)
          session.delete(:tagline)
          session.delete(:image_remote_url)
          session.delete(:last)
          format.html { redirect_to @project, notice: 'Project created successfully.' }
          format.json { render json: @project, status: :created, location: @project }
        else
          format.html { render action: "new" }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    else
      session[:last] = new_project_path
      session[:project_name] ||= params[:project][:project_name]
      session[:twitter] ||= params[:project][:twitter]
      session[:tagline] ||= params[:project][:tagline]
      session[:image_remote_url] ||= params[:project][:image_remote_url]
      redirect_to new_user_registration_path
    end
	end

	def show
		@project = Project.find(params[:id])
    @comment = Comment.new
    @show_comments = @project.comments.find(:all)
    
  #Metadata for social share buttons
    @title = "#{@project.project_name} - #{@project.tagline}"

    if current_user
      @user = current_user.id
    else
      @user = -1
    end
	end

  def edit
    @header = "Edit Project"
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.json { head :no_content }
    end
  end


	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:image, :image_remote_url, :project_name, :twitter, :tagline)
    end

    def admin_user
      unless current_user.try(:admin?)
        redirect_to(root_url)
        flash[:alert] = 'You must be an admin to access that page.'
      end
    end 
end
