module AwesomeController
  module ImplicitRendering
    def process(*)
      super

      if !performed?
        default_render
      end
    end

    def performed?
      @performed
    end

    private

    def default_render
      render
    end
  end
end
