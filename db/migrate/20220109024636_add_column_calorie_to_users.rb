class AddColumnCalorieToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :calorie, :integer, default: nil
    add_column :users, :carbohydrate, :integer, default: nil
    add_column :users, :protein, :integer, default: nil
    add_column :users, :lipid, :integer, default: nil
  end
end
