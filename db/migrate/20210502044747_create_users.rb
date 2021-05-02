class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :number
      t.string :firstname
      t.string :lastname
      t.string :post_index

      t.timestamps
    end
  end
end
