class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:title, :body],
                  using: {
                    tsearch: {
                      any_word: true,
                      prefix: true
                    }
                  }

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories, dependent: :destroy
  accepts_nested_attributes_for :post_categories, allow_destroy: true
  mount_uploader :image, ImageUploader

end
