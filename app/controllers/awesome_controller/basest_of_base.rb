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

    process(@action_name)

    @response.to_a
  end

  #  1) Creating and Viewing Posts (Custom Controller) creating posts allows a user to create a post
  #  Failure/Error: options[:prefixes] ||= _prefixes
  #  NoMethodError:
  #    undefined method `abstract?' for AwesomeController::Base:Class
  #    ./dependencies/rails/actionview/lib/action_view/view_paths.rb:25:in `_prefixes'
  #    ./dependencies/rails/actionview/lib/action_view/view_paths.rb:91:in `_prefixes'
  #    ./app/controllers/awesome_controller/implicit_rendering.rb:55:in `_normalize_options'
  #    ./app/controllers/awesome_controller/implicit_rendering.rb:31:in `render'
  #    ./app/controllers/awesome_controller/implicit_rendering.rb:24:in `default_render'
  #    ./app/controllers/awesome_controller/implicit_rendering.rb:13:in `process_action'
  #    ./app/controllers/awesome_controller/basest_of_base.rb:53:in `dispatch'
  #    ./app/controllers/awesome_controller/basest_of_base.rb:44:in `dispatch'
  #
  # Original code: abstract_controller/base.rb
  def self.abstract?
    true
  end

  # Failures:
  # 1) Creating and Viewing Posts (Custom Controller) creating posts allows a user to create a post
  #    Failure/Error: options[:prefixes] ||= _prefixes
  #    NameError:
  #      undefined local variable or method `controller_path' for OtherPostsController:Class
  #    # ./dependencies/rails/actionview/lib/action_view/view_paths.rb:69:in `local_prefixes'
  #    # ./dependencies/rails/actionview/lib/action_view/view_paths.rb:25:in `_prefixes'
  #    # ./dependencies/rails/actionview/lib/action_view/view_paths.rb:91:in `_prefixes'
  #    # ./app/controllers/awesome_controller/implicit_rendering.rb:55:in `_normalize_options'
  #    # ./app/controllers/awesome_controller/implicit_rendering.rb:31:in `render'
  #    # ./app/controllers/awesome_controller/implicit_rendering.rb:24:in `default_render'
  #    # ./app/controllers/awesome_controller/implicit_rendering.rb:13:in `process_action'
  #    # ./app/controllers/awesome_controller/basest_of_base.rb:53:in `dispatch'
  #    # ./app/controllers/awesome_controller/basest_of_base.rb:44:in `dispatch'
  #
  # Original code: abstract_controller/base.rb
  # Returns the full controller name, underscored, without the ending Controller.
  #
  #   class MyApp::MyPostsController < AbstractController::Base
  #
  #   end
  #
  #   MyApp::MyPostsController.controller_path # => "my_app/my_posts"
  #
  # ==== Returns
  # * <tt>String</tt>
  def self.controller_path
    @controller_path ||= name.sub(/Controller$/, "").underscore
  end

  # Performs the actual template rendering.
  def render_to_body(options = {})
  end

  # Stolen from abstract_controller/rendering.rb
  # Process extra options.
  def _process_options(options) # :doc:
    options
  end

  # Failures:
  #  1) Creating and Viewing Posts (Custom Controller) creating posts allows a user to create a post
  #  Failure/Error: super

  #  NoMethodError:
  #    undefined method `supports_path?' for OtherPostsController:Class
  #  # ./dependencies/rails/actionview/lib/action_view/rendering.rb:67:in `view_context_class'
  #  # ./dependencies/rails/actionview/lib/action_view/rendering.rb:78:in `view_context_class'
  #  # ./dependencies/rails/actionview/lib/action_view/rendering.rb:92:in `view_context'
  #  # ./dependencies/rails/actionview/lib/action_view/rendering.rb:111:in `_render_template'
  #  # ./dependencies/rails/actionview/lib/action_view/rendering.rb:103:in `render_to_body'
  #  # ./app/controllers/awesome_controller/implicit_rendering.rb:63:in `render_to_body'
  #  # ./app/controllers/awesome_controller/base.rb:11:in `render_to_body'
  #  # ./app/controllers/awesome_controller/implicit_rendering.rb:33:in `render'
  #  # ./app/controllers/awesome_controller/implicit_rendering.rb:25:in `default_render'
  #  # ./app/controllers/awesome_controller/implicit_rendering.rb:14:in `process_action'
  #  # ./app/controllers/awesome_controller/basest_of_base.rb:53:in `dispatch'
  #  # ./app/controllers/awesome_controller/basest_of_base.rb:44:in `dispatch'
  #
  # Stolen from abstract_controller/base.rb
  # Returns true if the given controller is capable of rendering
  # a path. A subclass of +AbstractController::Base+
  # may return false. An Email controller for example does not
  # support paths, only full URLs.
  def self.supports_path?
    true
  end

  private

  def process(action_name)
    send(action_name)
  end

  def _normalize_args(action = nil, options = {})
    options
  end

  def _normalize_options(options)
    options
  end

  def _set_rendered_content_type(format) # :nodoc:
  end

  def response_body=(body)
    @response.reset_body!
    @response.body = body

    @performed = true
  end
end
