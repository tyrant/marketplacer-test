class CreateCartItem < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :product
      t.integer :number
      t.timestamps
    end
  end
end
