class Api::PostsController < ActionController::API
  def index
    render(json: Post.all)
  end

  def create
    post = Post.new(post_params)

    if post.save
      render(json: post, status: :created) # Created status code
    else
      render(json: post.errors, status: :unprocessable_entity) # Unprocessable Entity status code
    end
  end

  def show
    render json: { post: Post.find(params[:id]) }
    #render(json: {"post":{"id":1,"title":"Hello","content":null,"created_at":"2019-05-19T19:51:27.175Z","updated_at":"2019-05-19T19:51:27.175Z"}})
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
