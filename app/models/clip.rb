class Clip < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  scope :clip_includes, -> {includes(shop: [:area, :shop_genres, :genres, :shop_images])}
end
