require 'rails_helper'

describe SearchItemsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'POST #create' do
    let(:params) {
      { search_item: { user_id: user.id, query: 'test_query', search_results_attributes: {
        '0': { twitter_id_number: '1234', twitter_screen_name: 'name' },
        '1': { twitter_id_number: '5678', twitter_screen_name: 'another_name' }
      } } }
    }
    context 'user is signed-in' do
      it 'creates a search item' do
        expect { post :create, params: params }.to change(SearchItem, :count).by(1)
      end

      it 'creates two search results' do
        expect { post :create, params: params }.to change(SearchResult, :count).by(2)
      end

      it 'gives the search item the correct data' do
        post :create, params: params
        expect(SearchItem.last.user).to eq(user)
        expect(SearchItem.last.query).to eq('test_query')
      end

      it 'gives the search results the correct data' do
        post :create, params: params
        expect(SearchResult.second_to_last.search_item).to eq(SearchItem.last)
        expect(SearchResult.second_to_last.twitter_id_number).to eq('1234')
        expect(SearchResult.second_to_last.twitter_screen_name).to eq('name')
        expect(SearchResult.last.search_item).to eq(SearchItem.last)
        expect(SearchResult.last.twitter_id_number).to eq('5678')
        expect(SearchResult.last.twitter_screen_name).to eq('another_name')
      end
    end

    context 'user is not signed-in' do
      it 'redirects to the sign-in page' do
        sign_out user
        get :create, params: params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #index' do
    context 'user is signed-in' do
      it 'returns http success' do
        get :index
        expect(response).to be_successful
      end
    end

    context 'user is not signed-in' do
      it 'redirects to the sign-in page' do
        sign_out user
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
