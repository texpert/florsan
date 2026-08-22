# frozen_string_literal: true

# Installing a Camaleon site (default plugins, theme, sample content, admin
# user) is expensive, so install one canonical site per suite run, committed
# outside the per-example transactions; example-level mutations still roll back
# with their transaction. Single-site resolution then makes request specs find
# it without any host mapping.
RSpec.configure do |config|
  config.before(:suite) do
    # Last line of defense for the purge below: only ever touch a *_test database.
    database = ActiveRecord::Base.connection_db_config.database
    abort("Refusing to purge #{database.inspect}: not a *_test database.") unless database.end_with?('_test')

    connection = ActiveRecord::Base.connection
    (connection.tables - %w[schema_migrations ar_internal_metadata]).each do |table|
      connection.execute("DELETE FROM #{connection.quote_table_name(table)}")
    end
    # Drop caches memoized during boot; they may hold sites the purge just deleted.
    CamaleonCms::Site.instance_variable_set(:@main_site, nil)
    PluginRoutes.instance_variable_set(:@all_sites, nil)
    PluginRoutes.instance_variable_get(:@cache)&.clear
    FactoryBot.create(:site)
  end

  config.before do
    # The shared site outlives examples, but these class-level caches must not:
    # an example that adds a site or toggles a plugin would poison later ones.
    CamaleonCms::Site.instance_variable_set(:@main_site, nil)
    PluginRoutes.instance_variable_set(:@all_sites, nil)
    PluginRoutes.instance_variable_get(:@cache)&.clear
  end
end
