class Api::FoodsController < ApplicationController
  def search
    @foods = Food.where('name like ?', "%#{params[:name]}%")
    if @foods.present?
      render json: @foods
    else
      render json: @foods, status: :not_found
    end
  end
end
