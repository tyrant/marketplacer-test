class Product < ApplicationRecord

  has_many :cart_items

  validates :name, uniqueness: true, allow_nil: false
  validates :price, numericality: {
      greater_than_or_equal_to: 0
    }
end