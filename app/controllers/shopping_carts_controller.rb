class ShoppingCartsController < ApplicationController

  def show
    @shopping_cart = ShoppingCart.includes(:cart_items).find(params[:id])
    @all_products = Product.all
    @promotions_applied = Promotion
      .where_threshold_up_to(@shopping_cart.sum_cart_items_subtotals)
  end


  private


  def shopping_cart_params
    params.require(:shopping_cart)
  end

end