class ShoppingCartsController < ApplicationController

  def show
    @shopping_cart = ShoppingCart.includes(:cart_items).find(params[:id])
    @all_products = Product.all
  end


  private


  def shopping_cart_params
    params.require(:shopping_cart)
  end

end