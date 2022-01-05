class ApplicationController < ActionController::Base

  def index
    redirect_to shopping_cart_path(ShoppingCart.order('id desc').first)
  end

end
