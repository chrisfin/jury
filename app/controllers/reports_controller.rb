class ReportsController < ApplicationController
	before_action :admin_user

  def index
    @reports = Report.all
  end

	def new
		@project = Project.find(params[:project_id])
    @header = "JudgeReport for #{@project.project_name}"
	  @report = Report.new
	  @grades = ["A","B","C","D","F"]
	end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'JudgeReport created successfully.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: 'new' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
		@report = Report.find(params[:id])
	end

	def edit
    @header = "Edit Project"
    @report = Report.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def update
    @report = Report.find(params[:id])
    @report.user_id = current_user.id
    
    if @report.update_attributes(report_params)
      flash[:success] = "JudgeReport updated"
      redirect_to @report
    else
      render 'edit'
    end
  end


	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:image, :project_id, :overall_grade, :fix_grade, :pain_grade)
    end

    def admin_user
      unless current_user.try(:admin?)
        redirect_to(root_url)
        flash[:alert] = 'You must be an admin to access that page.'
      end
    end 
end
