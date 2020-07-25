require "action_view"

module AwesomeController
  class Base < AwesomeController::SuperBase
    include AwesomeController::Rendering
    include AwesomeController::Callbacks
    include AwesomeController::Params
    include AwesomeController::ImplicitRendering
    include ActionView::Layouts
    include ActionView::ViewPaths
    include AwesomeController::UrlFor
    include AwesomeController::Redirecting
    include AwesomeController::Flash

    ActiveSupport.run_load_hooks(:awesome_controller, self)
  end
end
