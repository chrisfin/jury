class Project < ActiveRecord::Base
	has_attached_file :image, styles: { thumb: '120x120', large: '300x400' }
  
  validates_attachment :image, presence: true,
                            content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                            size: { less_than: 5.megabytes }
	belongs_to :user
end
