class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.integer :amount
      t.integer :fee
      t.boolean :refunded
      t.boolean :paid

      t.timestamps
    end
  end
end
