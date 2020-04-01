module AwesomeController
  module ImplicitRendering
    extend ActiveSupport::Concern

    def process(*)
      super

      if !performed?
        default_render
      end
    end

    def performed?
      @performed
    end

    private

    def default_render
      render
    end

    # Normalizes arguments, options and then delegates render_to_body and
    # sticks the result in <tt>self.response_body</tt>.
    def render(*args, &block)
      options = {}

      # This is a method provided by ActionView::Rendering that provides options like prefix and template.
      # For example, if this is the PostsController and the action is #show, then this will provide:
      #   {:prefixes=>["posts"], :template=>"show"}
      _normalize_options(options)

      rendered_body = render_to_body(options)
      # This is basically what Rails will do if the response is HTML.
      response.content_type = "text/html"
      self.response_body = rendered_body
    end
  end
end
