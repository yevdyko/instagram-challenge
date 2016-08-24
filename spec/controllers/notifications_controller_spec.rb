require 'rails_helper'

describe NotificationsController do
  describe 'GET #link_through' do
    before :each do
      user = create :user
      post = create(:post, user: user)
      notified_by_user = create :user
      @notification = create(:notification,
                             user: user,
                             post: post,
                             notified_by: notified_by_user)
    end

    it 'redirects to the commented post' do
      get :link_through, id: @notification
      expect(response).to redirect_to post_path(assigns(:notification))
    end

    it 'updates the read status to true' do
      get :link_through, id: @notification
      expect(assigns(:notification).read).to be true
    end
  end
end
