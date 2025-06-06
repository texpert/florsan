# frozen_string_literal: true

class PluginRoutes
  # draw "all" gems registered for the plugins or themes and camaleon gems
  def self.draw_gems
    res = []
    dirs = [] + Dir["#{apps_dir}/plugins/*"] + Dir["#{apps_dir}/themes/*"]

    dir_entries = %w[. ..]
    dirs.each do |path|
      next if dir_entries.include?(path)

      g = File.join(path, 'config', 'Gemfile')
      res << File.read(g) if File.exist?(g)
    end
    res.join("\n")
  end

  # return apps directory path
  def self.apps_dir
    dir = File.dirname(__FILE__).to_s.split('/')
    dir.pop
    "#{dir.join('/')}/app/apps"
  end
end
