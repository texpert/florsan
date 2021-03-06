# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'camaleon_cms', '>= 2.6'
# gem 'camaleon_cms', git: 'https://github.com/owen2345/camaleon-cms'
gem 'coffee-rails', '~> 5.0'
gem 'draper', '>= 3'
gem 'font-awesome-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'mini_racer'
gem 'pg'
gem 'puma', '~> 5.3'
gem 'rails', '~> 6.1'
gem 'sassc-rails'
gem 'turbolinks', '~> 5'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'benchmark-ips', '>= 2.9.1'
  gem 'derailed_benchmarks'
  gem 'listen', '~> 3.5'
  gem 'rack-mini-profiler', '~> 2.3'
  gem 'rubocop', '1.18.3', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'stackprof'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.alpha6'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#################### Camaleon CMS include all gems for plugins and themes ####################
require_relative './lib/plugin_routes'
instance_eval(PluginRoutes.draw_gems)
