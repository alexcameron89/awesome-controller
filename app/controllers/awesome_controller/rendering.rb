module AwesomeController
  module Rendering
    extend ActiveSupport::Concern
    include ActionView::ViewPaths

    # Normalizes arguments, options and then delegates render_to_body and
    # sticks the result in <tt>self.response_body</tt>.
    def render(*args, &block)
      options = args.first || {}

      # This is a method provided by ActionView::Rendering that provides options like prefix and template.
      # For example, if this is the PostsController and the action is #show, then this will provide:
      #   {:prefixes=>["posts"], :template=>"show"}
      _normalize_options(options)

      rendered_body = render_to_body(options)

      # This is basically what Rails will do if the response is HTML.
      # #rendered_format is provided by ActionView
      if rendered_format
        response.content_type = rendered_format.to_s
      end
      self.response_body = rendered_body
    end

    # This method provides the view with the instance variables
    # from the controller. This is how variables like @posts
    # are shared from the controller to the view.
    #
    # It does it by taking the instance variables, creating a
    # hash with the variable name minus '@' as the key and its
    # value as the value.
    #
    # Example:
    #   instance_variables -> [@posts]
    #   view_assigns -> { "posts" => [<Post id: 1>, <Post id 2>, ...] }
    #
    # In the view, it does the reverse, turning the values in view_assigns
    # into instance variables.
    #
    # That's done here in ActionView::Base:
    # https://github.com/rails/rails/blob/0ce8d452aa81c17073d9e1e4d60693afbe78e8c2/actionview/lib/action_view/base.rb#L206-L208
    #
    def view_assigns
      instance_variables.each_with_object({}) { |name, hash|
        hash[name.slice(1, name.length)] = instance_variable_get(name)
      }
    end

    # Required for ActionView::Rendering#render_to_body
    # Stolen from action_controller/metal/rendering.rb
    # Process controller specific options, as status, content-type and location.
    def _process_options(options)
      status = options[:status]

      response.status = status if status
    end

    # This is similar to an initializer for ActionController in the Rails engine:
    # https://github.com/rails/rails/blob/6d0895a4894724e1a923a514daad8fb3c9ac2c28/railties/lib/rails/engine.rb#L614
    views = Rails.application.paths["app/views"].existent
    unless views.empty?
      ActiveSupport.on_load(:awesome_controller) { prepend_view_path(views) if respond_to?(:prepend_view_path) }
    end

    private

    # By default, it should be nil
    def rendered_format
    end

    def _normalize_options(options)
      options
    end
  end
end
