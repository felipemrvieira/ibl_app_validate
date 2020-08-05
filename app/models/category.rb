class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories, dependent: :destroy
end
