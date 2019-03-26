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

module SimpleBlog
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
