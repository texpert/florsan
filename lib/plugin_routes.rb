# frozen_string_literal: true

class PluginRoutes
  # draw "all" gems registered for the plugins or themes and camaleon gems
  def self.draw_gems
    gemfiles = Dir["#{apps_dir}/{plugins,themes}/*/config/Gemfile"]

    # map + read + join is very memory efficient for strings
    # Ensuring a newline between files prevents syntax errors if a file lacks a trailing newline
    gemfiles.map { |gem| File.read(gem, encoding: 'UTF-8') }.join("\n\n")
  end

  # Returns the app's directory path
  # It is also defined in the Camaleon CMS gem, but it is used when loading gems, so camaleon_cms isn't yet loaded here
  def self.apps_dir
    File.join(File.dirname(__dir__), 'app', 'apps')
  end
end
