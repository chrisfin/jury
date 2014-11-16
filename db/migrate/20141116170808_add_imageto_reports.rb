class AddImagetoReports < ActiveRecord::Migration
  def self.up
    change_table :reports do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :reports, :image
  end
end
