class OtherPostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    @post.save

    redirect_to @post, notice: 'Post was successfully created.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
