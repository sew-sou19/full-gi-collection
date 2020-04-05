class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @shops = Shop.all.order(:id)
    @woms = Wom.all
    @top_areas = Area.limit(5).order_by_shops
    @areas = Area.all.order(:id)
    @top_genres = Genre.limit(5).order_by_shops
    @genres = Genre.all.order(:id)
    @top_brands = Brand.limit(5).order_by_shops
    @brands = Brand.all.order(:name)
    render layout: false
  end
end