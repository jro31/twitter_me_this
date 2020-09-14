class SearchItemsController < ApplicationController

  def create
    @search_item = SearchItem.new(search_item_params)

    if @search_item.save
      flash[:notice] = "Search saved"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong. Please try again later."
      redirect_to root_path
    end
  end

  def index
    return unless current_user

    @search_items = current_user.search_items
  end

  private

  def search_item_params
    params.require(:search_item).permit(
      :user_id, :query,
      search_results_attributes: %i(
        id twitter_id_number twitter_screen_name
      )
    )
  end
end
