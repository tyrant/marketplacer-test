class CartItem < ApplicationRecord

  belongs_to :product
  belongs_to :shopping_cart

  validates :product, presence: true
  validates :number, numericality: {
      only_integer: true,
      greater_than: 0
    }

  def price
    @price ||= product.price * number
  end
end