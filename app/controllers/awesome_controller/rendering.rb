module AwesomeController
  module Rendering
    extend ActiveSupport::Concern
    include ActionView::Rendering
    include AwesomeController::BasicRendering

    # Required for ActionView::Rendering#render_to_body
    # Stolen from action_controller/metal/rendering.rb
    # Process controller specific options, as status, content-type and location.
    def _process_options(options)
      status = options[:status]

      response.status = status if status
    end

    #    Failures:
    #
    #  1) Creating and Viewing Posts (Custom Controller) creating posts allows a user to create a post
    #     Failure/Error: super
    #
    #     NameError:
    #       undefined local variable or method `view_assigns' for #<OtherPostsController:0x00007f811b1ac838>
    #       Did you mean?  view_paths
    #     # ./dependencies/rails/actionview/lib/action_view/rendering.rb:92:in `view_context'
    #     # ./dependencies/rails/actionview/lib/action_view/rendering.rb:111:in `_render_template'
    #     # ./dependencies/rails/actionview/lib/action_view/rendering.rb:103:in `render_to_body'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:63:in `render_to_body'
    #     # ./app/controllers/awesome_controller/base.rb:11:in `render_to_body'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:33:in `render'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:25:in `default_render'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:14:in `process_action'
    #     # ./app/controllers/awesome_controller/basest_of_base.rb:53:in `dispatch'
    #     # ./app/controllers/awesome_controller/basest_of_base.rb:44:in `dispatch'
    #
    #     Original code: abstract_controller/rendering.rb
    def view_assigns
      instance_variables.each_with_object({}) { |name, hash|
        hash[name.slice(1, name.length)] = instance_variable_get(name)
      }
    end

    # This is similar to an initializer for ActionController in the Rails engine:
    # https://github.com/rails/rails/blob/6d0895a4894724e1a923a514daad8fb3c9ac2c28/railties/lib/rails/engine.rb#L614
    views = Rails.application.paths["app/views"].existent
    unless views.empty?
      ActiveSupport.on_load(:awesome_controller) { prepend_view_path(views) if respond_to?(:prepend_view_path) }
    end
  end
end
