# frozen_string_literal: true

source 'https://rubygems.org'

ruby file: '.tool-versions'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.8.1', require: false
gem 'camaleon_cms', '>= 2.8.3'
# gem 'camaleon_cms', git: 'https://github.com/owen2345/camaleon-cms'
gem 'dartsass-sprockets'
gem 'draper', '>= 3'
gem 'genericons-rails'
gem 'net-http' # Promoted to stdlib in Ruby 3.0, required here to avoid "already initialized constant errors"
gem 'non-digest-assets', '~> 2.6'
gem 'openssl'
gem 'pg'
gem 'psych'
gem 'puma', '7.2.0'
gem 'rails', '~> 8.1'
gem 'sprockets-rails', '>= 3.5.1', require: 'sprockets/railtie'
gem 'turbolinks', '~> 5'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
end

group :development do
  gem 'benchmark-ips', '>= 2.9.1'
  # TODO: Re-enable when the issue with ruby-statistics gem will be solved
  # gem 'derailed_benchmarks'
  gem 'localhost', require: 'localhost/authority'
  gem 'rack-mini-profiler', '~> 4.0'
  gem 'stackprof'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#################### Camaleon CMS include all gems for plugins and themes ####################
require_relative 'lib/plugin_routes'
instance_eval(PluginRoutes.draw_gems)
