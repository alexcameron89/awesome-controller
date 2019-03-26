module AwesomeController
  # The Rails UrlFor does more than what's provided here, but this module
  # simply takes advantage of UrlFor and helpers provided by the Router.
  module UrlFor
    extend ActiveSupport::Concern
    include ActionDispatch::Routing::UrlFor
    include Rails.application.routes.url_helpers
  end
end
