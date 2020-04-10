module AwesomeController
  module BasicRendering
    extend ActiveSupport::Concern

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

    private

    # By default, it should be nil
    def rendered_format
    end

    def _normalize_options(options)
      options
    end
  end
end
