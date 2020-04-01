module AwesomeController
  module Redirecting
    extend ActiveSupport::Concern

    def redirect_to(options = {}, response_options = {})
      response.status = 302
      response.location = compute_redirect_to_location(request, options)
      self.response_body = "Redirecting"
    end

    private

    def compute_redirect_to_location(request, options)
      case options
      when String
        request.protocol + request.host_with_port + options
      else
        url_for(options)
      end
    end
  end
end
