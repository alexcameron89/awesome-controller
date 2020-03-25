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
  end
end
