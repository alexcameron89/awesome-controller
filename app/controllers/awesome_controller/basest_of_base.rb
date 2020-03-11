class AwesomeController::BasestOfBase

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

  attr_reader :action_name, :request, :response
  def dispatch(action_name, request, response)
    @action_name = action_name
    @request = request
    @response = response

    process_action(@action_name)

    @response.to_a
  end

  private

  def process_action(action_name)
    send(action_name)
  end
end
