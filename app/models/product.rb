class Product < ApplicationRecord

  validates :name, uniqueness: true, allow_nil: false
  validates :price, numericality: {
      greater_than_or_equal_to: 0
    }
end