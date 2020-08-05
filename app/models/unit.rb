class Unit < ApplicationRecord
  extend FriendlyId

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :timeoutable,
         :recoverable, :rememberable, :validatable

  has_many :students, dependent: :destroy
  has_many :courses
  has_one :address, dependent: :destroy
  mount_uploaders :images, ImageUploader
  mount_uploader :cover, CoverUploader

  accepts_nested_attributes_for :address

  friendly_id :title, use: :slugged

  scope :keyword, lambda {|keyword| where(["title LIKE :term", {:term => "%#{keyword}%"}]) }

end
