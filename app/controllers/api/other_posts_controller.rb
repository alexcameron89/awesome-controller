class Api::OtherPostsController < ActionController::API
  def index
    binding.pry
    render json: Post.all
  end
end
