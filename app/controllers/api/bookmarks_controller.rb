class Api::BookmarksController < ApplicationController
  def index
  end

  def create
    binding.pry
    food = Food.find(params[:id])
    current_user.bookmark(food)
    render json: food
  end

  def destroy
    food = Food.find(params[:id])
    current_user.unbookmark(food)
    render json: food
  end
end
