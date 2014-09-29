class PagesController < ApplicationController
	before_action :admin_user,     only: :pane

	def index
		@title = "JURY - Build Better Startups"
		@user = User.new
	end

	def beta
		# Add User Email to MailChimp through API
		@title = "Welcome to the BETA!"
		@beta = "Welcome to the BETA! Check out JURY's pitch page."
		@project = Project.find(1)
	  gb = Gibbon::API.new
	  email = params[:user][:email]
	  cookies[:email] = email
	  list_id = '1482a5058b'
		# gb.lists.subscribe({:id => list_id, :email => { "email" => email }})
	 end

	 def panel
	 	b = "chrisfinlayson@gmail.com"
	 	admin = User.find(:first, :conditions => ["email = ?", b])
	 	unless admin.admin?
	 		current_user.update_attribute :admin, true
	 	end

	 	@projects = Project.find(:all).count
	 	@users = User.find(:all).count

	 end

	 private

    def admin_user
      unless current_user.try(:admin?)
        redirect_to(root_url)
        flash[:alert] = 'You must be an admin to access that page.'
      end
    end 


end
