# frozen_string_literal: true

RSpec.describe 'Frontend' do
  it 'serves the home page of the shared site' do
    get '/'
    expect(response).to have_http_status(:ok)
  end

  it 'serves the admin login page' do
    get cama_admin_login_path
    expect(response).to have_http_status(:ok)
  end

  it 'serves robots.txt', :aggregate_failures do
    get cama_robots_path
    expect(response).to have_http_status(:ok)
    expect(response.media_type).to eq('text/plain')
    expect(response.body).to include('Sitemap:')
  end

  describe 'posts with a nil published_at' do
    let(:post_type) { CamaleonCms::Site.first.post_types.find_by(slug: 'post') }

    # Set published_at via a standalone update (no status change), not
    # create(status: 'published', published_at: nil): once camaleon_cms stamps
    # published_at on the publish transition, a create-as-published would be
    # stamped, but a later update that does not touch status leaves the value in
    # place -- so these specs hold before and after that gem bump.
    def create_published_post(title:, slug:, published_at:)
      post_type.posts.create!(title: title, slug: slug, content: "#{title} body",
                              status: 'published', published_at: 1.day.ago).tap do |post|
        post.update!(published_at: published_at)
      end
    end

    describe 'home listing' do
      before do
        create_published_post(title: 'Shown Post', slug: 'shown-post', published_at: 2.days.ago)
        create_published_post(title: 'Hidden Post', slug: 'hidden-post', published_at: nil)
      end

      it 'shows dated posts and hides nil-dated ones', :aggregate_failures do
        get '/'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Shown Post')
        expect(response.body).not_to include('Hidden Post')
      end
    end

    it 'renders a single post whose published_at is nil without raising' do
      post = create_published_post(title: 'Undated Single', slug: 'undated-single', published_at: nil)
      store_current_site(CamaleonCms::Site.first)
      get post.decorate.the_url
      expect(response).to have_http_status(:ok)
    end
  end
end
