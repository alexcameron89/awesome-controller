class AwesomeController::Api
  include AwesomeController::Params
  # NoMethodError:
  #  undefined method `binary_params_for?' for Api::OtherPostsController:Class
  # ./dependencies/rails/actionpack/lib/action_dispatch/http/parameters.rb:100:in `binary_params_for?'
  # ./dependencies/rails/actionpack/lib/action_dispatch/http/parameters.rb:91:in `set_binary_encoding'
  # ./dependencies/rails/actionpack/lib/action_dispatch/http/parameters.rb:69:in `path_parameters='
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:48:in `block in serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `each'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/routing/route_set.rb:843:in `call'
  def self.binary_params_for?(thing)
    false
  end

  # NoMethodError:
  #  undefined method `make_response!' for Api::OtherPostsController:Class
  # ./dependencies/rails/actionpack/lib/action_dispatch/routing/route_set.rb:32:in `serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:50:in `block in serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `each'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/routing/route_set.rb:843:in `call'
  #
  # def serve(req)
  #   params     = req.path_parameters
  #   controller = controller req
  #=> res        = controller.make_response! req
  def self.make_response!(request)
    ActionDispatch::Response.new.tap do |res|
      res.request = request
    end
  end

  # NoMethodError:
  # undefined method `dispatch' for Api::OtherPostsController:Class
  #
  # ./dependencies/rails/actionpack/lib/action_dispatch/routing/route_set.rb:50:in `dispatch'
  # ./dependencies/rails/actionpack/lib/action_dispatch/routing/route_set.rb:33:in `serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:50:in `block in serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `each'
  # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `serve'
  # ./dependencies/rails/actionpack/lib/action_dispatch/routing/route_set.rb:843:in `call'
  def self.dispatch(action_name, request, response)
    new.dispatch(action_name, request, response)
  end

  def dispatch(action, request, response)
    @action = action
    @request = request
    @response = response

    send(@action)

    @response.to_a
  end

  # @response.body = [stuff] is similar to how metal does it.
  #  - action_controller/metal.rb:174 -
  #
  # def response_body=(body)
  #   body = [body] unless body.nil? || body.respond_to?(:each)
  #   response.reset_body!
  #   return unless body
  #   response.body = body
  #   super
  # end
  def render(json:, status: nil)
    #  This ensures that the status code is in the integer format
    #
    #  This combines code from two places
    #  action_controller/metal/rendering.rb:101 , #_normalize_options for symbol to int
    #  actionpack/lib/action_controller/metal/rendering.rb:118 for setting the status
    if status
      @response.status = Rack::Utils.status_code(status)
    end

    @response.reset_body!
    @response.body = [json.to_json]
  end
end
