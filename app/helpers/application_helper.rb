# frozen_string_literal: true

module ApplicationHelper
  # rubocop:disable Rails/HelperInstanceVariable
  def adjust_aws_settings(settings)
    settings[:aws_settings][:aws_file_upload_settings] =
      lambda { |settings| # rubocop:disable Lint/ShadowingOuterLocalVariable
        @suppress_content_type ||= false
        settings[:content_type] = params['file_upload']&.content_type unless @suppress_content_type
        settings
      }
  end

  def content_type_only_for_svg(args)
    @suppress_content_type = true unless args[:key].match?(/\.svgz?\z/)
  end
  # rubocop:enable Rails/HelperInstanceVariable
end
