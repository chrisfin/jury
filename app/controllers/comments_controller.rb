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
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text, :project_id)
    end

end
