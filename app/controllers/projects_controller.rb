class ProjectsController < ApplicationController

	def new
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
          format.html { redirect_to @project, notice: 'Pin was successfully created.' }
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
	end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:image, :image_remote_url, :project_name, :twitter, :tagline)
    end

end
