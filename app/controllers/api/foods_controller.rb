class Api::FoodsController < ApplicationController
  def search_name
    foods = Food.where('name like ?', "%#{params[:name]}%")
    render_foods(foods)
  end

  def search_nutrient
    foods = search_protein
    if foods.present?
      foods = search_carbohydrate(foods)
      foods = search_lipid(foods)
    end
    render_foods(foods)
  end

  private

  def render_foods(foods)
    render json: foods
  end

  def search_protein
    if nutrient_params[:proteinMaximum].present?
      Food.where(protein: nutrient_params[:proteinMinimum]..nutrient_params[:proteinMaximum])
    else
      Food.where(protein: nutrient_params[:proteinMinimum]..)
    end
  end

  def search_carbohydrate(foods)
    if nutrient_params[:carbohydrateMaximum].present?
      foods.where(carbohydrate: nutrient_params[:carbohydrateMinimum]..nutrient_params[:carbohydrateMaximum])
    else
      foods.where(carbohydrate: nutrient_params[:carbohydrateMinimum]..)
    end
  end

  def search_lipid(foods)
    if nutrient_params[:lipidMaximum].present?
      foods.where(lipid: nutrient_params[:lipidMinimum]..nutrient_params[:lipidMaximum])
    else
      foods.where(lipid: nutrient_params[:lipidMinimum]..)
    end
  end

  def nutrient_params
    params.permit(:proteinMinimum, :proteinMaximum, :carbohydrateMinimum, :carbohydrateMaximum, :lipidMinimum, :lipidMaximum)
  end
end
