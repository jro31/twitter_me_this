require 'rails_helper'

describe SearchItem do
  it { should belong_to :user }
  it { should have_many :search_results }

  let(:search_item) { create(:search_item) }

  describe 'destroying a search item destroys their search results' do
    let!(:search_result) { create(:search_result, id: 999, search_item: search_item) }
    it 'destroys the search result' do
      expect(SearchResult.find(999)).to eq(search_result)
      search_item.destroy
      expect { SearchResult.find(999) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
