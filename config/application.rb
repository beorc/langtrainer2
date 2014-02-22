require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Langtrainer2

  def self.config
    Application.config
  end

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Moscow'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :ru
    config.i18n.fallbacks = false
    config.i18n.available_locales = [:ru, :en]

    config.action_mailer.default_options = { from: '"Languages training service LANGTRAINER.COM" <noreply@langtrainer.com>',
                                             reply_to: '"Languages training service LANGTRAINER.COM" <noreply@langtrainer.com>' }

    config.boxes_number = 5
    config.boxes_probabilities = [60, 25, 10, 8, 2]

    config.autoload_paths += %W(#{config.root}/lib)
  end
end
