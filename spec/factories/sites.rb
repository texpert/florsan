# frozen_string_literal: true

FactoryBot.define do
  factory :site, class: 'CamaleonCms::Site' do
    name { Faker::Name.unique.name }
    sequence(:slug) { |n| "test-site-#{n}" }
    description { Faker::Lorem.sentence }

    transient do
      theme { 'florsan_first' }
      skip_intro { true }
    end

    after(:create) do |site, evaluator|
      # site_after_install resolves current_site, which needs a request once a
      # second site exists; pin the new site as current for the install instead.
      previous_site = CurrentRequest.site
      CurrentRequest.site = site.decorate
      CamaInstaller.build.site_after_install(site, evaluator.theme)
      site.set_option('save_intro', true) if evaluator.skip_intro
      # The installer may mint a random admin password; reset the site admin to
      # the well-known credentials specs sign in with.
      admin = site.users.where(role: 'admin').first
      if admin
        admin.update(password: 'admin123', password_confirmation: 'admin123')
        admin.delete_meta('must_change_password')
      end
    ensure
      CurrentRequest.site = previous_site
    end
  end
end
