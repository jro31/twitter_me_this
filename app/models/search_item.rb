class SearchItem < ApplicationRecord
  belongs_to :user
  has_many :search_results, dependent: :destroy
end
