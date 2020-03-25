require "action_view"

class AwesomeController::Base < AwesomeController::BasestOfBase
  include AwesomeController::Callbacks
  include AwesomeController::Params
  include AwesomeController::ImplicitRendering
  include ActionView::ViewPaths
  include AwesomeController::Flash
  include AwesomeController::UrlFor

  delegate :headers, :status=, :location=, :content_type=,
    :status, :location, :content_type, :media_type, to: "@response"

  # Performs the actual template rendering.
  def render_to_body(options = {})
    super
  end

  # Stolen from action_controller/metal/rendering.rb
  # Process controller specific options, as status, content-type and location.
  def _process_options(options)
    status, content_type, location = options.values_at(:status, :content_type, :location)

    self.status = status if status
    self.content_type = content_type if content_type
    headers["Location"] = url_for(location) if location

    super
  end

  def _normalize_options(options)
    super
  end

  def _set_rendered_content_type(format)
    if format && !response.media_type
      self.content_type = format.to_s
    end
  end

  ActiveSupport.run_load_hooks(:awesome_controller, self)
end
