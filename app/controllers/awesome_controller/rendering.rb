module AwesomeController
  module Rendering
    # Performs the actual template rendering.
    def render_to_body(options = {})
      super
    end

    # Stolen from action_controller/metal/rendering.rb
    # Process controller specific options, as status, content-type and location.
    def _process_options(options)
      status, content_type, location = options.values_at(:status, :content_type, :location)

      response.status = status if status
      response.content_type = content_type if content_type
      headers["Location"] = url_for(location) if location
    end

    # This is similar to an initializer for ActionController in the Rails engine:
    # https://github.com/rails/rails/blob/6d0895a4894724e1a923a514daad8fb3c9ac2c28/railties/lib/rails/engine.rb#L614
    views = Rails.application.paths["app/views"].existent
    unless views.empty?
      ActiveSupport.on_load(:awesome_controller) { prepend_view_path(views) if respond_to?(:prepend_view_path) }
    end
  end
end
