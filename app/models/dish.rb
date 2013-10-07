class Dish < ActiveRecord::Base
  
  has_many :dishes_icons
  accepts_nested_attributes_for :dishes_icons, allow_destroy: true

  attr_accessible :name, :dishes_icons_attributes
end
