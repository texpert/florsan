# frozen_string_literal: true

require_relative 'boot'

# require 'rails/all'

# require "action_cable/engine"
# require "action_mailbox/engine"
require 'action_mailer/railtie'
require 'action_controller/railtie'
# require 'action_text/railtie'
require 'action_view/railtie'
require 'active_job/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
# require 'active_storage/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Florsan
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Rails.autoloaders.main.ignore(Rails.root.join('app/channels/application_cable'))
