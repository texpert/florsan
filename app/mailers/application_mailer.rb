# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'FlorSan Admin <branzeanu.aurel@gmail.com>'
  layout 'mailer'
end
