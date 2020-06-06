module Themes::FlorsanFirst::MainHelper
  def self.included(klass)
    klass.helper_method [:get_taxonomy] rescue "" # here your methods accessible from views
  end

  def florsan_first_load_app

  end

  def florsan_first_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  def get_taxonomy(taxonomies = {}, rel = '')
    list = []
    if taxonomies.present?
      taxonomies.each do |taxonomy|
        list << "<a href='#{taxonomy.the_url}' rel='#{rel}'>#{taxonomy.the_title}</a>"
      end
    end
    list.join(', ')
  end

  # callback called after theme installed
  def florsan_first_on_install_theme(theme)
    # # Sample Custom Field
    # unless theme.get_field_groups.where(slug: "fields").any?
    #   group = theme.add_field_group({name: "Main Settings", slug: "fields", description: ""})
    #   group.add_field({"name"=>"Background color", "slug"=>"bg_color"},{field_key: "colorpicker"})
    #   group.add_field({"name"=>"Links color", "slug"=>"links_color"},{field_key: "colorpicker"})
    #   group.add_field({"name"=>"Background image", "slug"=>"bg"},{field_key: "image"})
    # end

    # # Sample Meta Value
    # theme.set_meta("installed_at", Time.current.to_s) # save a custom value
    theme.add_field({"name"=>"Footer message", "slug"=>"footer"},{field_key: "editor", default_value: 'Copyright
&copy; 2020 - Florsan. All rights reservated.'})
  end

  # callback executed after theme uninstalled
  def florsan_first_on_uninstall_theme(theme)
  end
end
