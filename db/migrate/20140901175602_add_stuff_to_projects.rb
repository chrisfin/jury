class AddStuffToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :image_remote_url, :string
  	add_column :projects, :user_id, :integer
    add_index :projects, :user_id
  end
end
