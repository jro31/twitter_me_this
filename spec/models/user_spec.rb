require 'rails_helper'

describe User do
  it { should have_many :search_items }

  let(:user) { create(:user) }

  describe 'destroying a user destroys their search items' do
    let!(:search_item) { create(:search_item, id: 999, user: user) }
    it 'destroys the search item' do
      expect(SearchItem.find(999)).to eq(search_item)
      user.destroy
      expect { SearchItem.find(999) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
