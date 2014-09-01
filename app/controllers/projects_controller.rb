class ProjectsController < ApplicationController

	def new
	  @project = Project.new
	end

	def create
		@project = current_user.projects.build(project_params)
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Pin was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
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
      params.require(:project).permit(:image)
    end

end
