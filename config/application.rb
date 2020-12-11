require_relative 'boot'
require 'uri'


require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module IblSemLegendaRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :"pt-BR"
    # config.assets.initialize_on_precompile = false
    config.assets.precompile += %w( login.css )
    config.serve_static_assets = true
    config.time_zone = 'Brasilia'

    config.cache_store = :memory_store, { size: 200.megabytes }

    config.action_controller.allow_forgery_protection = false



    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
