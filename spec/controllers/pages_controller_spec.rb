require 'rails_helper'

describe PagesController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #home' do
    context 'user is signed-in' do
      it 'returns http success' do
        get :home
        expect(response).to be_successful
      end
    end

    context 'user is not signed-in' do
      it 'returns http success' do
        sign_out user
        get :home
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #display_followers' do
    context 'user is signed-in' do
      context 'follower_details is nil' do
        it 'redirects to root' do
          allow_any_instance_of(PagesController).to receive(:follower_details).and_return(nil)
          get :display_followers
          expect(response).to redirect_to root_path
        end
      end

      context 'follower_details is empty' do
        it 'redirects to root' do
          allow_any_instance_of(PagesController).to receive(:follower_details).and_return({})
          get :display_followers
          expect(response).to redirect_to root_path
        end
      end

      context 'follower_details exists' do
        it 'returns http success' do
          allow_any_instance_of(PagesController).to receive(:follower_details).and_return({ '1234': 'test_name' })
          get :display_followers
          expect(response).to be_successful
        end
      end
    end

    context 'user is not signed-in' do
      context 'follower_details exists' do
        it 'returns http success' do
          sign_out user
          allow_any_instance_of(PagesController).to receive(:follower_details).and_return({ '1234': 'test_name' })
          get :display_followers
          expect(response).to be_successful
        end
      end
    end
  end
end
