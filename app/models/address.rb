class Address < ApplicationRecord
  belongs_to :unit
  validates_presence_of :city

end
