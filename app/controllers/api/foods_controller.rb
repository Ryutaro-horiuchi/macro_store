class Api::FoodsController < ApplicationController
  def search_name
    foods = Food.where('name like ?', "%#{params[:name]}%")
    render json: foods
  end

  def search_nutrient
    foods = Food.protein_bitween(nutrient_params[:proteinMinimum], nutrient_params[:proteinMaximum])
                .carbohydrate_bitween(nutrient_params[:carbohydrateMinimum], nutrient_params[:carbohydrateMaximum])
                .lipid_bitween(nutrient_params[:lipidMinimum], nutrient_params[:lipidMaximum])
    render json: foods
  end

  private

  def nutrient_params
    params.permit(:proteinMinimum, :proteinMaximum, :carbohydrateMinimum, :carbohydrateMaximum, :lipidMinimum, :lipidMaximum)
  end
end
