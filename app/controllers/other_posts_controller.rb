class OtherPostsController < AwesomeController::Base
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.save

    redirect_to other_post_path(@post.id), notice: 'Congratulations on your successful post.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
