class PostsController < ApplicationController
  def index
    puts "#" * 90
    puts caller.reverse
    puts "#" * 90
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
