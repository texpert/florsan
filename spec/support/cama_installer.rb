# frozen_string_literal: true

# Builds a lightweight context able to run Camaleon's provisioning helpers
# (site_after_install, plugin_install, site_install_theme) outside a controller.
#
# Lifecycle hooks (a theme's on_active, a plugin's plugin_after_install, ...)
# are plain methods that the CMS resolves with `send` on whatever object runs
# the install — inside the app that object is a controller carrying every app's
# helper module. Mirror that here by extending the union of all discovered
# apps' helpers, so hook dispatch during provisioning in specs never hits
# NoMethodError.
module CamaInstaller
  def self.build
    context = Object.new.extend(CamaleonCms::SiteHelper, CamaleonCms::HooksHelper)
    PluginRoutes.all_apps.each do |info|
      Array(info['helpers']).each do |helper_name|
        context.extend(helper_name.constantize)
      rescue StandardError
        nil # an app with a broken/missing helper class must not break provisioning
      end
    end
    context
  end
end
