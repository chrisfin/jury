class PagesController < ApplicationController

	def index
		@user = User.new
	end

	def beta
		# Add User Email to MailChimp through API
	  gb = Gibbon::API.new
	  email = params[:user][:email]
	  list_id = '1482a5058b'
	  gb.lists.subscribe({:id => list_id, :email => { "email" => email }, :double_optin => false})
	    
	 end


end
