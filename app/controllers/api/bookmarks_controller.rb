class Api::BookmarksController < ApplicationController
  def create
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
