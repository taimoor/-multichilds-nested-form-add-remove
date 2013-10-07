class Dish < ActiveRecord::Base
  #assosiation for nested model
  has_many :dishes_icons
  # Must add "allow_destroy: true" in the line below to provide remove functionality
  accepts_nested_attributes_for :dishes_icons, allow_destroy: true

  # add :assosiation_attributes to attr_accessible to acces nested model attributes
  attr_accessible :name, :dishes_icons_attributes
end
