class DishesController < ApplicationController
  before_filter :load_dish, only: [:edit, :update, :destroy]

  def index
    @dishes = Dish.all
  end

  def show
    @dish = Dish.find(params[:id])
  end
# Multi Fields generation in nested form --> Start
  def new
    @dish = Dish.new
    @dish_icons = @dish.dishes_icons.build
  end

  def edit
    @dish_icons = @dish.dishes_icons
    @dish_icons ||= @dish.dishes_icons.build
  end
# Multi Fields generation in nested form --> End
  def create
    @dish = Dish.new(params[:dish])
    if @dish.save
      redirect_to @dish, notice: 'Dish was successfully created.'
    else
      render action: "new"
    end
  end

  def update
      if @dish.update_attributes(params[:dish])
        redirect_to @dish, notice: 'Dish was successfully updated.'
      else
        render action: "edit"
      end
  end

  def destroy
    @dish.destroy
    redirect_to dishes_url
  end

  private

  def load_dish
    @dish = Dish.find(params[:id])
  end
end
