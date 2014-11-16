class PagesController < ApplicationController
	before_action :admin_user,     only: :panel

	def beta
		@title = "Welcome to the BETA!"
		@beta = "Welcome to the BETA! Check out JURY's pitch page."
		@project = Project.find(1)
	  
		# Add User Email to MailChimp through API
	  gb = Gibbon::API.new

	  @gb = gb.api_key
	  if gb.api_key && cookies[:email]
	  	list_id = '1482a5058b'
			gb.lists.subscribe({:id => list_id, :email => { "email" => cookies[:email] }})
		end
	 end

	 def access
	 	b = "chrisfinlayson@gmail.com"
	 	admin = User.find(:first, :conditions => ["email = ?", b])
	 	unless admin.admin?
	 		current_user.update_attribute :admin, true
	 	end
	 end

	 def panel
	 	@lists = List.find(:all).count ||= 0
	 	@projects = Project.find(:all).count ||= 0
	 	@users = User.find(:all).count ||= 0
	 	@reports = Report.find(:all).count ||= 0

	 end

	 private

    def admin_user
      unless current_user.try(:admin?)
        redirect_to(root_url)
        flash[:alert] = 'You must be an admin to access that page.'
      end
    end 

end
