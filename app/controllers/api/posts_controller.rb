class Api::PostsController
  REQUIRED_PARAM = :post
  PERMITTED_PARAMS = [:title, :content]

  def index
    render json: Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors, status: 422
    end
  end

  def post_params
    request.params
      .fetch(REQUIRED_PARAM)
      .select { |k,v| PERMITTED_PARAMS.include?(k.to_sym) }
  end

  # This method creates a response object on the controller before calling
  # the action. This was done to ensure that the controller has a Response
  # object in the beginning and prevents conditional logic on whether or
  # not it exists at response time.
  #
  # See https://github.com/rails/rails/commit/51c7ac142d31095d4c699f44cc44ddea627da1eb
  #
  # ## When this is called
  # This method is called when the router serves the request to the route (RouteSet)
  # and the route starts fullfilling the request
  #
  # ActionDispatch::Routing::RouteSet::Dispatcher#serve
  # https://github.com/rails/rails/blob/cecbc2340abec0ba96db9394f397f1e5a67c449d/actionpack/lib/action_dispatch/routing/route_set.rb#L29-L40
  #
  # The serve method is called from the router:
  # https://github.com/rails/rails/blob/cecbc2340abec0ba96db9394f397f1e5a67c449d/actionpack/lib/action_dispatch/journey/router.rb#L49
  def self.make_response!(request)
    Response.new(request)
  end

  # This method gets called by the route's ActionDispatch::Routing::RouteSet::Dispatcher#serve
  # method, which calls the action and returns [status, headers, body].
  # The returned [s,h,b] gets returned up to the router (ActionDispatch::Journey::Router),
  # which then passes it back up the middleware chain. The router is the meat to the Rails
  # request middleware sandwich.
  def self.dispatch(action_name, request, response)
    controller = new(request: request, response: response)
    controller.dispatch(action_name)
    controller.to_a
  end

  attr_accessor :request, :response
  def initialize(request:, response:)
    @request = request
    @response = response
  end

  def render(json:, status: 200)
    response.reset_body!
    response.body << json.to_json
    response.status = status
  end

  def dispatch(action_name)
    public_send(action_name)
  end

  def to_a
    response.to_a
  end

  class Response
    attr_accessor :status, :headers, :body
    def initialize(request)
      @request = request
      @status = 200
      @headers = {}
      @body = []
    end

    def reset_body!
      @body = []
    end

    def to_a
      [status, headers, body]
    end
  end
end
