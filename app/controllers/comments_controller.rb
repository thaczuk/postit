class CommentsController < ApplicationController
  before_filter :require_user

  def show
  end

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user_id = session[:user_id]
    @comment.post = @post

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      render action: 'posts/show'
    end
  end

  def edit
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
