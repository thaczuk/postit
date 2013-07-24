class CommentsController < ApplicationController
  before_filter :require_user

  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

def vote
   @comment = Comment.find(params[:id])
   #if current_user.already_voted?(@comment)
    #  flash[:error] = "You can only vote once"
   #   redirect_to :back
  #else
    Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    respond_to do |format|
        format.html do
          redirect_to :back, notice: "You voted."
        end
        format.js
    end
  #end
end


end
