module AwesomeController
  module Params
    class ParameterMissingError < StandardError
      def initialize(param)
        super("param is missing or the value is empty: #{param}")
      end
    end

    class Parameters
      def initialize(params)
        @params = params
      end

      def [](key)
        @params[key]
      end

      def require(attribute)
        value = Parameters.new(@params.fetch(attribute))
      end

      def permit(*attributes)
        @params.select { |a| a.to_sym.in?(attributes) }
      end
    end

    def params
      @_params ||= Parameters.new(@request.params)
    end
  end
end
