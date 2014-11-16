class Report < ActiveRecord::Base
	has_attached_file :image, styles: { thumb: '120x120', large: '700x450', twitter: '1000x500', facebook: '1000x500' }, 
    :convert_options => {:facebook => "-gravity center -extent 1000x500^"}
  
  validates_attachment :image, presence: true,
                            content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                            size: { less_than: 2.megabytes }
  validates :overall_grade, presence: true
  validates :pain_grade, presence: true
  validates :fix_grade, presence: true
  belongs_to :user
  belongs_to :project
  
end
