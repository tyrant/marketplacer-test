class Promotion < ApplicationRecord

  validates :percentage, numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    }
  validates :threshold, numericality: {
      greater_than_or_equal_to: 0
    }
end