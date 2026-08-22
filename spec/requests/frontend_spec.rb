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
end
