class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :field1
      t.text :field2
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :users
  end
end
