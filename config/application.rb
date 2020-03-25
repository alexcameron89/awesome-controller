require_relative 'boot'

require "rails"

%w(
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ActiveSupport::JSON::Encoding.time_precision = 0

module Journey
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators do |g|
      g.test_framework :rspec
    end

    # This is similar to an initializer for ActionController in the Rails engine:
    # https://github.com/rails/rails/blob/6d0895a4894724e1a923a514daad8fb3c9ac2c28/railties/lib/rails/engine.rb#L614
    views = paths["app/views"].existent
    unless views.empty?
      ActiveSupport.on_load(:awesome_controller) { prepend_view_path(views) if respond_to?(:prepend_view_path) }
    end
  end
end
