class CreateShoppingCart < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_carts do |t|
      t.decimal :total
      t.timestamps
    end

    change_table :cart_items do |t|
      t.references :shopping_cart
    end
  end
end
