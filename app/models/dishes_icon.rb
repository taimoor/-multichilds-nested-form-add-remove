class DishesIcon < ActiveRecord::Base
  belongs_to :dish
  belongs_to :icon
  attr_accessible :dish_id, :icon_id
end
