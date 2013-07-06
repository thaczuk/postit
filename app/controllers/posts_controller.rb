class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
# root_path           GET         /                                     posts#index
# posts_path         GET        /posts(.:format)               posts#index
#                           POST      /posts(.:format)               posts#create
# new_post_path   GET        /posts/new(.:format)       posts#new
# edit_post_path    GET       /posts/:id/edit(.:format)  posts#edit
# post_path           GET       /posts/:id(.:format)          posts#show
#                           PATCH   /posts/:id(.:format)          posts#update
#                           PUT       /posts/:id(.:format)          posts#update

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
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
end