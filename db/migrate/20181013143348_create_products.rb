class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.text :description
      t.integer :stock
      t.integer :category_id
      t.boolean :cod_eligible
      t.datetime :release_datetime

      t.timestamps
    end
  end
end
