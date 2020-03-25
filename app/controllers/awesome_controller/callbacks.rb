module AwesomeController
  module Callbacks
    extend ActiveSupport::Concern

    # Uses ActiveSupport::Callbacks as the base functionality. For
    # more details on the whole callback system, read the documentation
    # for ActiveSupport::Callbacks.
    include ActiveSupport::Callbacks

    # ActiveSupport::Callbacks builds out the basic functionality.
    #
    # It provides the following methods:
    # - `define_callback` - I believe this defines a callback type. For instance, you would
    #   defined a `:save` callback type so that you can set callbacks before and after save.
    #   Then when going to save, you'd wrap the save functionality in `run_callbacks(:save)
    # - `set_callback` - This sets a callback before, around or after. Its typing looks like:
    #   `set_callback :save, :before, :before_method`
    # - `run_callbacks` - This is where the callback methods actually get called.

    included do
      define_callbacks :process_action
    end

    def process(*)
      run_callbacks(:process_action) do
        super
      end
    end

    module ClassMethods

      def before_action(method_name, **options)
        normalized_options = normalize_options(options)
        set_callback(:process_action, :before, method_name, normalized_options)
      end

      private

      # ActiveSupport::Callbacks doesn't know about :only or :except. It knows about :if, and :unless,
      # and each require a method that returns true or false.
      #
      # This method takes the :only list, and converts it into a method for if that asks
      # a controller instance, "is your action listed in this list?
      def normalize_options(options)
        if only_list = options[:only]
          # This creates a proc that takes a controller insatance and asks
          # "Is the controller's action in this `only` list?
          options[:if] = proc { |controller| only_list.map(&:to_s).include?(controller.action_name) }
        end

        options
      end
    end
  end
end
