class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true, null: false
      t.string :postal_code,                     null: false
      t.string :address,                         null: false
      t.string :name,                            null: false
      t.integer :postage,                        null: false
      t.integer :total_price,                    null: false
      t.integer :payment_method,                 null: false, default: 0
      t.integer :status,                         null: false, default: 0
      t.timestamps
    end
  end
end
