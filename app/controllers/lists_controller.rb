class ListsController < ApplicationController
	before_action :admin_user,     only: :index

	def index
		@title = "JURY - Build Better Startups"
		@lists = List.all
	end

	def new
		@list = List.new
	end

	def create
    @list = List.new(list_params)

	  # Add User Email to MailChimp through API
	 	gb = Gibbon::API.new
	  list_id = '1482a5058b'
		# gb.lists.subscribe({:id => list_id, :email => { "email" => email }})

    if @list.save
    	email = params[:list][:email]
  		cookies[:email] = email
			redirect_to action: 'beta', controller: 'pages'
    else
			render "new"
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_path }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:email)
    end

	  def admin_user
	    unless current_user.try(:admin?)
	      redirect_to(root_url)
	      flash[:alert] = 'You must be an admin to access that page.'
	    end
	  end 
end
