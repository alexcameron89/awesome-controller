class Api::OtherPostsController < ActionController::API
  def index
    binding.pry
    render json: Post.all
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: post, status: 201 # Created status code
    else
      render json: post.errors, status: 422 # Unprocessable Entity status code
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
