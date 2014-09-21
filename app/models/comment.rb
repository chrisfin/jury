class Comment < ActiveRecord::Base
	belongs_to :project
	belongs_to :users

	validates :text, presence: true

end
