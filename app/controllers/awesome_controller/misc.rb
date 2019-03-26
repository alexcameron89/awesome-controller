module AwesomeController
  # This is a module for methods that don't add much to the purpose of
  # AwesomeController but are needed to its implementation. With each
  # method is the error that occurred without the method.
  module Misc
    # NoMethodError:
    #  undefined method `binary_params_for?' for Api::OtherPostsController:Class
    # ./dependencies/rails/actionpack/lib/action_dispatch/http/parameters.rb:100:in `binary_params_for?'
    # ./dependencies/rails/actionpack/lib/action_dispatch/http/parameters.rb:91:in `set_binary_encoding'
    # ./dependencies/rails/actionpack/lib/action_dispatch/http/parameters.rb:69:in `path_parameters='
    # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:48:in `block in serve'
    # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `each'
    # ./dependencies/rails/actionpack/lib/action_dispatch/journey/router.rb:32:in `serve'
    # ./dependencies/rails/actionpack/lib/action_dispatch/routing/route_set.rb:843:in `call'
    def binary_params_for?(thing)
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
    def make_response!(request)
      ActionDispatch::Response.new.tap do |res|
        res.request = request
      end
    end
  end
end
