class AddProjectNametoProject < ActiveRecord::Migration
  def change
  	remove_column :projects, :company_name, :string
  	add_column :projects, :project_name, :string
  end
end
