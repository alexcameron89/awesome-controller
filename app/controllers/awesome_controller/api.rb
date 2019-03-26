module AwesomeController
  # The AwesomeController::Api class provides a minimal implementation of
  # ActionController::API. It's a controller that provides the ability to render JSON.
  class Api < AwesomeController::SuperBase
    include AwesomeController::Params
    include AwesomeController::JsonRenderer
  end
end
