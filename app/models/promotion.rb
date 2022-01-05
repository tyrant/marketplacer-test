class Promotion < ApplicationRecord

  validates :percentage, numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    }
  validates :threshold, numericality: {
      greater_than_or_equal_to: 0
    }


  def as_json(params={})
    {
      id:         id,
      percentage: percentage.to_f,
      threshold:  threshold.to_f
    }
  end


  # We need to progressively apply to our @pre_discount_subtotal each of our
  # stored Promotions, in ascending order of their threshold money values, up to
  # and including the single Promotion with threshold of greater value than our 
  # subtotal, but no further.
  # I'd toyed with making this a scope, but I'm not sure it's possible to query
  # both all Promotions below a threshold, plus exactly one above it, in just
  # a single query. So it's a static method instead.
  # Yes scopes are supposed to be syntactic sugar for static methods, but
  # we'd expect scopes to refrain from actually executing our queries, and 
  # instead stick to good old lazy loading. Chainable. This loads them.
  def Promotion.where_threshold_up_to(value)
    all_promotions_below_subtotal = Promotion
      .where('threshold < ?', value)
    first_promotion_above_subtotal = Promotion
      .where('threshold > ?', value)
      .limit(1)

    [all_promotions_below_subtotal, first_promotion_above_subtotal]
      .flatten
      .sort_by do |promotion|
        promotion.threshold
      end
  end
end