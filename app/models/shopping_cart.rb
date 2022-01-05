class ShoppingCart < ApplicationRecord

  has_many :cart_items, dependent: :destroy

  # The spec is a bit vague about exactly how different promotions fight 
  # each other, so I'm going to assume that the different combos of percentages
  # and dollar-total thresholds apply progressively, like tax brackets.
  def total
    _sum_cart_items_subtotals
    _progressively_apply_promotions
  end


  #private 


  def _sum_cart_items_subtotals
    @pre_discount_total = cart_items.map do |cart_item|
      cart_item.product.price * cart_item.number
    end.sum
  end


  def _progressively_apply_promotions
    @post_discount_total = 0

    # To compare each Promotion's threshold value with its lower neighbour's
    # threshold value, we can either suffer an N+1 bug or just simply yoink
    # the entire table.
    all_promotions = Promotion.order('threshold asc').as_json

    all_promotions.each_with_index do |promotion, i|

      # If our promotions values go higher than the current pre-total,
      # calculate only up to that pre-total then exit the promotion-loop.
      if @pre_discount_total < promotion[:threshold]
        discountable_money = total - promotion[:threshold]
        @post_discount_total += discountable_money * promotion[:percentage]/100
        break
      end

      discountable_money = promotion[:threshold]
      discountable_money -= all_promotions[i-1][:threshold] if i>0

      @post_discount_total += discountable_money * promotion[:percentage]/100
    end

    # Has the total exceeded even the highest promotion threshold? Apply
    # the maximum threshold's percentage discount to the pre-total remainder.
    if @pre_discount_total > all_promotions.last[:threshold]
      discountable_remainder = @pre_discount_total - all_promotions.last[:threshold]
      @post_discount_total += discountable_remainder * all_promotions.last[:percentage]
    end
    
    @post_discount_total
  end
end