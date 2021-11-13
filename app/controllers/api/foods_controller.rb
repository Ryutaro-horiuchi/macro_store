class Api::FoodsController < ApplicationController
  def name_search
    @foods = Food.where('name like ?', "%#{params[:name]}%")
    render_foods
  end

  def nutrient_search
    # pluckメソッドでリファクタリングができるかもしれない　
    @foods = protein_search
    @foods = carbo_search(@foods)
    @foods = lipid_search(@foods)
    render_foods
  end

  private

  def render_foods
    render json: @foods
  end

  def protein_search
    if !protein_params[:maximum].nil?
      Food.where(protein: protein_params[:minimum]..protein_params[:maximum])
    else
      Food.where(protein: protein_params[:minimum]..)
    end
  end

  def carbo_search(foods)
    if !carbo_params[:maximum].nil?
      foods.where(carbohydrate: carbo_params[:minimum]..carbo_params[:maximum])
    else
      foods.where(carbohydrate: carbo_params[:minimum]..)
    end
  end

  def lipid_search(foods)
    if !lipid_params[:maximum].nil?
      foods.where(lipid: lipid_params[:minimum]..lipid_params[:maximum])
    else
      foods.where(lipid: lipid_params[:minimum]..)
    end
  end

  def protein_params
    params.require(:proteinValue).permit(:minimum, :maximum)
  end

  def carbo_params
    params.require(:carboValue).permit(:minimum, :maximum)
  end

  def lipid_params
    params.require(:lipidValue).permit(:minimum, :maximum)
  end
end
