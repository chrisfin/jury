class Comment < ActiveRecord::Base
	belongs_to :project
	belongs_to :users

end
