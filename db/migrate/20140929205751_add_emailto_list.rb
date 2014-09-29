class AddEmailtoList < ActiveRecord::Migration
  def change
  	add_column :lists, :email, :string
  end
end
