class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate!, only: %i[me]

  def create
    user = User.new(user_params)
    if user.save!
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def update
    if current_user.update!(update_params)
      render json: current_user
    else
      render json: curretn_user.errors, status: :bad_request
    end
  end

  def me
    render json: { user: current_user, foods: current_user.bookmark_foods }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :calorie, :carbohydrate, :protein, :lipid)
  end

  def update_params
    params.require(:user).permit(:name, :email, :calorie, :carbohydrate, :protein, :lipid)
  end
end
