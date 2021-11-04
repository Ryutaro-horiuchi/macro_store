class Api::FoodsController < ApplicationController
  def search
    @foods = Food.where('name like ?', "%#{params[:name]}%")
    render_foods
  end

  def search_nutrient
    binding.pry
    if params[:maximum] != nil
      @foods = Food.where(protein: params[:minimum]..params[:maximum])
    else
      @foods = Food.where(protein: params[:minimum]..)
    end
    render_foods
  end

  private

  def render_foods
    if @foods.present?
      render json: @foods
    else
      render json: @foods, status: :not_found
    end
  end
end
