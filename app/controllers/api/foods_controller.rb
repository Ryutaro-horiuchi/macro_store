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
    if protein_params[:maximum].present?
      Food.where(protein: protein_params[:minimum]..protein_params[:maximum])
    else
      Food.where(protein: protein_params[:minimum]..)
    end
  end

  def search_carbohydrate(foods)
    if carbohydrate_params[:maximum].present?
      foods.where(carbohydrate: carbohydrate_params[:minimum]..carbohydrate_params[:maximum])
    else
      foods.where(carbohydrate: carbohydrate_params[:minimum]..)
    end
  end

  def search_lipid(foods)
    if lipid_params[:maximum].present?
      foods.where(lipid: lipid_params[:minimum]..lipid_params[:maximum])
    else
      foods.where(lipid: lipid_params[:minimum]..)
    end
  end

  def protein_params
    params.require(:proteinValue).permit(:minimum, :maximum)
  end

  def carbohydrate_params
    params.require(:carbohydrateValue).permit(:minimum, :maximum)
  end

  def lipid_params
    params.require(:lipidValue).permit(:minimum, :maximum)
  end
end
