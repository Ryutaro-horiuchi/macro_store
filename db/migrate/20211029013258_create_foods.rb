class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :calorie, null: false
      t.float :carbohydrate, null: false
      t.float :protein, null: false
      t.float :lipid, null: false
      t.integer :store, null: false
      t.string  :image
      t.timestamps
    end

    add_index :foods, [:name, :calorie, :carbohydrate, :protein, :lipid], :name => 'food_index'
  end
end
