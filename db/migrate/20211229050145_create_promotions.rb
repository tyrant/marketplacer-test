class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.decimal :percentage
      t.decimal :threshold
      t.timestamps
    end
  end
end
