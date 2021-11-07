class Api::FoodsController < ApplicationController
  def search_name
    @foods = Food.where('name like ?', "%#{params[:name]}%")
    render_foods
  end

  def search_nutrient
      @foods = protein_search
      @foods = carbo_search(@foods)
      @foods = lipid_search(@foods)
    # @foods = Food.where(protein: protein_params[:minimum]..protein_params[:maximum])
    #              .where(carbo: carbo_params[:minimum]..carbo_params[:maximum])
    # if params[:maximum] != nil
    #   @foods = Food.where(protein: params[:minimum]..params[:maximum])
    # else
    #   @foods = Food.where(protein: params[:minimum]..)
    # end
    render_foods
  end

  private

  def render_foods
    binding.pry
    if @foods.present?
      render json: @foods
    else
      render json: @foods, status: :not_found
    end
  end

  def protein_search
   if protein_params[:maximum] != nil
      Food.where(protein: protein_params[:minimum]..protein_params[:maximum])
    else
      Food.where(protein: protein_params[:minimum]..)
    end
  end

  def carbo_search(foods)
    binding.pry
    if carbo_params[:maximum] != nil
      foods.where(carbohydrate: carbo_params[:minimum]..carbo_params[:maximum])
    else
      foods.where(carbohydrate: carbo_params[:minimum]..)
    end
  end

  def lipid_search(foods)
    if lipid_params[:maximum] != nil
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
