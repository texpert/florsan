# frozen_string_literal: true

module ApplicationHelper
  # rubocop:disable Rails/HelperInstanceVariable
  def adjust_aws_settings(settings)
    settings[:aws_settings][:aws_file_upload_settings] = lambda do |settings|
      @suppress_content_type ||= false
      settings[:content_type] = params['file_upload']&.content_type unless @suppress_content_type
      settings
    end
  end

  def content_type_only_for_svg(args)
    @suppress_content_type = true unless args[:key].match?(/\.svgz?\z/)
  end

  def on_render_sitemap(_options)
    lookup_context.formats = [:html] if params[:format] == 'txt'
  end
  # rubocop:enable Rails/HelperInstanceVariable
end
