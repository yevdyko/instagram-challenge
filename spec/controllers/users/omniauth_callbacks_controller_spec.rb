require 'rails_helper'

describe Users::OmniauthCallbacksController do
  before do
    valid_facebook_login_setup
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth']  = OmniAuth.config.mock_auth[:facebook]
  end

  describe 'GET #facebook' do
    it 'expects omniauth.auth to be truthy' do
      get :facebook, params: { provider: :facebook }
      expect(request.env['omniauth.auth']).to be_truthy
    end

    it 'completes the registration process succesfully' do
      get :facebook, params: { provider: :facebook }
      expect(response).to redirect_to root_path
    end

    it 'creates a user succesfully' do
      expect do
        get :facebook, params: { provider: :facebook }
      end.to change{ User.count }.by(1)
    end
  end

  describe 'GET #failure' do
    it 'renders a failure message on unsuccessful authentication' do
      get :failure
      expect(flash[:alert]).to eq t('omniauth.failure')
      expect(response).to redirect_to root_path
    end
  end
end
