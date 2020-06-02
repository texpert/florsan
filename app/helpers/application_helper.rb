module ApplicationHelper
  def adjust_aws_settings(settings)
    settings[:aws_settings][:aws_file_upload_settings] =
      lambda { |file_settings| file_settings.merge({acl: 'bucket-owner-full-control'})  }
  end
end
