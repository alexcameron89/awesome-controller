class Api::PostsController < ActionController::API
  def index
    render json: Post.all
  end
end
