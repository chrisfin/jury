class Project < ActiveRecord::Base
	has_attached_file :image, styles: { thumb: '120x120', large: '700x450', twitter: '1000x500', facebook: '1000x500' }, 
    :convert_options => {:facebook => "-gravity center -extent 1000x500^"}
  
  validates_attachment :image, presence: true,
                            content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                            size: { less_than: 2.megabytes }
  validates :tagline, presence: true
  validates :project_name, presence: true
	belongs_to :user
	has_many :comments

	def image_remote_url=(url_value)
  	self.image = URI.parse(url_value) unless url_value.blank?	
  	super
  end


end
