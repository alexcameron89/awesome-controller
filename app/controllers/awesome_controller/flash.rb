module AwesomeController
  module Flash
    extend ActiveSupport::Concern
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
