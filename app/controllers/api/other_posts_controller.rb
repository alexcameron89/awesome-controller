class Api::OtherPostsController < AwesomeController::Api
  def show
    render json: { post: Post.find(params[:id]) }
  end

  # curl -X POST -H "Content-Type: application/json" 0.0.0.0:3000/api/posts -d '{"post":{"title":"Hello"}}'
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: { post: @post }, status: 201
    else
      render json: { errors: @post.errors }, status: 422
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
