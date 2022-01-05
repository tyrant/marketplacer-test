class ShoppingCart < ApplicationRecord

  has_many :cart_items, dependent: :destroy

  def include?(product)
    cart_items.map(&:product).include? product
  end

  # The spec is a bit vague about exactly how different promotions fight 
  # each other, so I'm going to assume that the different combos of percentages
  # and dollar-total thresholds apply progressively, like tax brackets.
  def total
    sum_cart_items_subtotals
    apply_promotional_discounts

    @post_discount_total
  end


  def sum_cart_items_subtotals
    @pre_discount_subtotal ||= cart_items.map(&:price).sum
  end


  def apply_promotional_discounts
    promotions = Promotion.where_threshold_up_to(@pre_discount_subtotal)

    # We need to compare each Promotion's threshold value with its 
    # predecessor's, so using a standard #each iterator would mean extra N+1 
    # queries to grab those values. Easier just to convert the whole lot to an 
    # #as_json hash and use a #with_index iterable instead
    sum_discount_subtotals = promotions.as_json.map.with_index do |promotion, i|

      discountable_for_this_threshold = if promotion[:threshold] > @pre_discount_subtotal
          @pre_discount_subtotal - promotion[:threshold]
        elsif i > 0
          promotion[:threshold] - promotions[i-1][:threshold]
        else
          promotion[:threshold]
        end

      discountable_for_this_threshold * promotion[:percentage]/100

    end.sum

    # Has the subtotal exceeded even the highest threshold? Apply
    # the maximum threshold's percentage discount to the pre-total remainder.
    if @pre_discount_subtotal > promotions.last[:threshold]
      discountable_remainder = @pre_discount_subtotal - promotions.last[:threshold]
      sum_discount_subtotals += (discountable_remainder * promotions.last[:percentage]/100)
    end

    @post_discount_total ||= @pre_discount_subtotal - sum_discount_subtotals
  end


end