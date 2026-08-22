# frozen_string_literal: true

require 'spec_helper'

# Hard assignment, deliberately not `||=`: a shell that exports RAILS_ENV
# (common on dev machines here: RAILS_ENV=development) would otherwise boot the
# suite in that environment and point it — including the destructive
# before(:suite) database purge — at that environment's database.
ENV['RAILS_ENV'] = 'test'
require_relative '../config/environment'

abort("RSpec must run in the test environment, got #{Rails.env}!") unless Rails.env.test?

# Refuse to run against anything but a *_test database, no matter what the
# environment resolution did. The purge in spec/support/shared_site.rb checks
# this again on its own.
current_database = ActiveRecord::Base.connection_db_config.database
unless current_database.end_with?('_test')
  abort("RSpec is connected to #{current_database.inspect}, which is not a *_test database. Refusing to run.")
end

require 'rspec/rails'

# Load the schema when the test database is empty, then fail loudly on drift.
# Deliberately NOT ActiveRecord::Migration.maintain_test_schema!: it reconstructs
# the schema through a `bin/rails` subprocess that runs the protected-environments
# check, which on this machine can resolve to a non-test database (the production
# config here falls back to the development database) and abort. Run manual db
# tasks for this app with RAILS_ENV=test (e.g. `RAILS_ENV=test bin/rails db:test:prepare`).
begin
  connection = ActiveRecord::Base.connection
  if !connection.table_exists?('schema_migrations') ||
     connection.select_value('SELECT COUNT(*) FROM schema_migrations').to_i.zero?
    ActiveRecord::Tasks::DatabaseTasks.load_schema(ActiveRecord::Base.connection_db_config)
  end
  ActiveRecord::Migration.check_all_pending!
rescue ActiveRecord::PendingMigrationError => e
  abort "#{e.to_s.strip}\nRun: RAILS_ENV=test bin/rails db:test:prepare"
end

Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join('spec/fixtures')]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include CurrentSpecHelper

  config.before do
    # Reset per-request state so nothing leaks between examples.
    CurrentRequest.reset
    # Frontend locale resolution assigns I18n.locale process-wide; reset it so an
    # example that ran a request cannot change the locale of later examples.
    I18n.locale = I18n.default_locale # rubocop:disable Rails/I18nLocaleAssignment
  end
end
