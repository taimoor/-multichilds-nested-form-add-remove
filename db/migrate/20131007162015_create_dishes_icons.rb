class CreateDishesIcons < ActiveRecord::Migration
  def change
    create_table :dishes_icons do |t|
      t.integer :icon_id
      t.integer :dish_id

      t.timestamps
    end
  end
end
