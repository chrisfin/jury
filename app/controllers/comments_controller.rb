class CommentsController < ApplicationController

	def new
    @comment = Comment.new
  end

  # GET /comment/1/edit
  def edit
  end

  # POST /comment
  def create
    @comment = Comment.new(comment_params)

    if user_signed_in?
    	@comment.user_id = current_user.id
    end

    respond_to do |format|
      if @comment.save
        store_comment(@comment.id, @comment.user_id)
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  	@comment = Comment.find(params[:id])
  end

  def claim
    session[:claim] = params[:project_id]
    redirect_to new_user_registration_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text, :project_id)
    end

    def store_comment(comment, user)
      unless user
        if session[:comment]
          session[:comment] << comment
        else
          session[:comment] = Array.new
          session[:comment] << comment
        end
      end
    end

end
