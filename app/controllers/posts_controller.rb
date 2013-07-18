class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_filter :require_user, only: [:new, :create, :edit, :update]
  before_action :require_creator, only: [:edit, :create]


  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      redirect_to @post, notice: 'Post was successfully created'
    else
      render action: 'new'
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
    @post = Post.find(params[:id])
    @comment =  @post.comments.build
    @comments = Comment.where(post_id: (params[:id]))
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet
    def post_params
      params.require(:post).permit(:title, :url, :description)
    end

    def require_creator
      access_denied unless logged_in? && current_user == @post.creator
    end
end