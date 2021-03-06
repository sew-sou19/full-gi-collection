class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_shop
  before_action -> {
    admin_check(@shop)
  }, only: [:new, :edit, :update, :delete]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_items, only: [:index, :new, :create, :edit]
  before_action :set_clip_user_and_shop, only: [:index, :new]

  def index
    @top_brands = @shop.brands.limit(5)
    @brands = @shop.brands.order(:name)
    render template: 'shops/items'
  end

  def new
    @item = Item.new
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    @item.save! ? (redirect_to shop_items_path(@shop.id)):(render :new)
  end

  def show
  end

  def edit
  end

  def update
    @item.update(item_params) ? (redirect_to shop_items_path(@shop.id)):(render :edit)
  end

  def destroy
    @item.destroy ? (redirect_to shop_items_path(@shop.id)):(render :index)
  end

  def import
    Item.import(params[:file], @shop.id)
    redirect_to shop_items_path(@shop.id)
  end

  private
  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def set_items
    @items = @shop.items.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def item_params
    params.require(:item).permit(
      :name,
      :explanation,
      :price,
      :item_status_id,
      :size,
      :size_detail,
      images: [],
    )
    .merge(shop_id: params[:shop_id])
  end

  def set_clip_user_and_shop
    @clip = Clip.where(user_id: current_user).where(shop_id: @shop.id)
  end
end
