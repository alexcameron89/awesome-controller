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
        attribute = @params[key]
        attribute.kind_of?(Hash) ? Parameters.new(attribute) : attribute
      end

      def require(attribute)
        required_params = self[attribute]
        if required_params.present?
          required_params
        else
          raise ParameterMissingError.new(attribute)
        end
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
