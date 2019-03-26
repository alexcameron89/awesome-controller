module AwesomeController
  # Flash provides a way to set flash messages on the request for `redirect_to` & a `notice` method
  # to pull the flash information from the request. Very little code was needed here since
  # the Flash implementation mostly lives on the request, provided by the Flash middleware.
  #
  # See Flash middleware here:
  # https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/middleware/flash.rb
  module Flash
    extend ActiveSupport::Concern
    # I cheated a bit to get Flash working by using Helpers provided
    # by AbstractController. Re-implementing that module required more work
    # than I wanted to provide a Flash implementation, and I couldn't find a
    # very easy way to simplify the Helpers code for educational purposes.
    #
    # View the AbstractController::Helpers code here:
    # https://github.com/rails/rails/blob/master/actionpack/lib/abstract_controller/helpers.rb
    include AbstractController::Helpers

    included do
      add_flash_types
    end

    module ClassMethods
      def add_flash_types
        define_method(:notice) do
          request.flash[:notice]
        end
        helper_method(:notice)
      end
    end

    def redirect_to(options = {}, response_options_and_flash = {})
      if flash_message = response_options_and_flash.delete(:notice)
        request.flash[:notice] = flash_message
      end

      super(options, response_options_and_flash)
    end
  end
end
