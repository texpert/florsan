# frozen_string_literal: true

# Helpers to manage Camaleon's per-request state (CurrentRequest) in specs.
module CurrentSpecHelper
  def store_current_user(user)
    CurrentRequest.user = user
  end

  def store_current_site(site)
    CurrentRequest.site = site.respond_to?(:decorated?) ? site : site.decorate
  end

  # Sign in for request specs: sets CurrentRequest and the auth-token cookie the
  # CMS resolves the admin session from.
  def sign_in_as(user, site: nil)
    store_current_user(user)
    store_current_site(site || user.site)
    return unless defined?(cookies) && user.respond_to?(:auth_token)

    cookies[:auth_token] = "#{user.auth_token}&rspec&127.0.0.1"
  end

  def reset_current
    CurrentRequest.reset
  end
end
