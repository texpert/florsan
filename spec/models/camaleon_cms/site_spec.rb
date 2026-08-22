# frozen_string_literal: true

RSpec.describe CamaleonCms::Site do
  describe 'the suite shared site' do
    it 'is provisioned with default content types and an admin', :aggregate_failures do
      site = described_class.first
      expect(site).to be_present
      expect(site.post_types.pluck(:slug)).to include('post', 'page')
      expect(site.users.where(role: 'admin')).to exist
      expect(site.get_theme_slug).to eq('florsan_first')
    end
  end

  describe 'provisioning a new site' do
    it 'installs the default plugins and the requested theme', :aggregate_failures do
      site = create(:site)
      expect(site.plugins.pluck(:slug))
        .to include('front_cache', 'cama_contact_form', 'attack', 'cama_meta_tag')
      expect(site.themes.where(slug: 'florsan_first')).to exist
    end
  end
end
