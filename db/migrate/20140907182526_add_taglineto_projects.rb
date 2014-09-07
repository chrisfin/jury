class AddTaglinetoProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :company_name, :string
  	add_column :projects, :tagline, :string
  	add_column :projects, :twitter, :string
  end
end
