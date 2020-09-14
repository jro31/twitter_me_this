class SearchItem < ApplicationRecord
  belongs_to :user
  has_many :search_results, dependent: :destroy

  accepts_nested_attributes_for :search_results
end
