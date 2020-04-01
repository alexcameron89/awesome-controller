require "action_view"
require "action_view/view_paths"

module AwesomeController
  module ImplicitRendering
    extend ActiveSupport::Concern
    include ActionView::ViewPaths
    include ActionView::Rendering

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

    # Normalizes arguments, options and then delegates render_to_body and
    # sticks the result in <tt>self.response_body</tt>.
    def render(*args, &block)
      options = _normalize_args(*args, &block)
      _normalize_options(options)
      rendered_body = render_to_body(options)
      response.content_type = "text/html"
      self.response_body = rendered_body
    end

    def _normalize_args(action = nil, options = {})
      options = super
    end

    # Normalize options.
    def _normalize_options(options)
      options = super(options)
      if options[:partial] == true
        options[:partial] = action_name
      end

      if (options.keys & [:partial, :file, :template]).empty?
        options[:prefixes] ||= _prefixes
      end

      options[:template] ||= (options[:action] || action_name).to_s
      options
    end

    def render_to_body(options)
      super
    end

    #    Failures:
    #
    #  1) Creating and Viewing Posts (Custom Controller) creating posts allows a user to create a post
    #     Failure/Error: super
    #
    #     NameError:
    #       undefined local variable or method `view_assigns' for #<OtherPostsController:0x00007f811b1ac838>
    #       Did you mean?  view_paths
    #     # ./dependencies/rails/actionview/lib/action_view/rendering.rb:92:in `view_context'
    #     # ./dependencies/rails/actionview/lib/action_view/rendering.rb:111:in `_render_template'
    #     # ./dependencies/rails/actionview/lib/action_view/rendering.rb:103:in `render_to_body'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:63:in `render_to_body'
    #     # ./app/controllers/awesome_controller/base.rb:11:in `render_to_body'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:33:in `render'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:25:in `default_render'
    #     # ./app/controllers/awesome_controller/implicit_rendering.rb:14:in `process_action'
    #     # ./app/controllers/awesome_controller/basest_of_base.rb:53:in `dispatch'
    #     # ./app/controllers/awesome_controller/basest_of_base.rb:44:in `dispatch'
    #
    #     Original code: abstract_controller/rendering.rb
    def view_assigns
      instance_variables.each_with_object({}) { |name, hash|
        hash[name.slice(1, name.length)] = instance_variable_get(name)
      }
    end

  end
end
