class CartItemsController < ApplicationController

  before_action :_load_shopping_cart
  before_action :_load_cart_item, only: [:increment, :decrement, :destroy]


  # POST /shopping_carts/:shopping_cart_id/cart_items
  def create
    @cart_item = @shopping_cart.cart_items.new(
        number: 1,
        product_id: params[:product_id]
      )
    @cart_item.save!
  end


  # PATCH /shopping_carts/:shopping_cart_id/cart_items/:cart_item_id/increment
  def increment
    @cart_item.number += 1
    @cart_item.save!
  end


  # PATCH /shopping_carts/:shopping_cart_id/cart_items/:cart_item_id/increment
  def decrement
    @cart_item.number -= 1
    @cart_item.save!
  end


  # PATCH /shopping_carts/:shopping_cart_id/cart_items/:cart_item_id
  def destroy
    @cart_item.destroy
  end


  private


  def _load_shopping_cart
    @shopping_cart = ShoppingCart.find(params[:shopping_cart_id])
  end


  def _load_cart_item
    @cart_item = @shopping_cart.cart_items.find(params[:id])
  end


  def cart_item_params
  end
  
end