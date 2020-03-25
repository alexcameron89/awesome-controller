module AwesomeController
  module UrlFor
    extend ActiveSupport::Concern
    include ActionDispatch::Routing::UrlFor
    include Rails.application.routes.url_helpers

    def url_options
      super
    end
  end
end
