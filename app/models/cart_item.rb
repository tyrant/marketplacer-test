class CartItem < ApplicationRecord

  belongs_to :product

  validates :product, presence: true
  validates :number, numericality: {
      only_integer: true,
      greater_than: 0
    }
end