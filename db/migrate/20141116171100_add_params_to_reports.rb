class AddParamsToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :project_id, :integer
  	add_column :reports, :user_id, :integer
  	add_column :reports, :overall_grade, :string
  	add_column :reports, :fix_grade, :string
  	add_column :reports, :pain_grade, :string
  end
end
