module AwesomeController
  module JsonRenderer
    def render_to_body(options)
      json = options[:json]
      status = options[:status]

      @response.status = status unless status.nil?
      @response.content_type = "application/json"

      self.response_body = json.to_json
    end
  end
end
