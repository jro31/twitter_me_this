require 'rails_helper'

describe SearchItem do
  it { should belong_to :user }
  it { should have_many :search_results }
end
