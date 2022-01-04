class ApplicationController < ActionController::Base

  def index
    redirect_to "/cart"
  end

  def cart
    @all_products = Product.all
  end

end
