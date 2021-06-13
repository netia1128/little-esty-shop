class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :discount
      t.integer :item_quantity

      t.references :merchant, foreign_key: true

      t.timestamps
    end
    execute("ALTER SEQUENCE bulk_discounts_id_seq START with 500 RESTART;")
  end
end
