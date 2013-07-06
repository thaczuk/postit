class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'comment was successfully created' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def new
    @comment = Comment.new
  end

  private
    # Never trust parameters from the scary internet
    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
end