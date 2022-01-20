class Api::SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password])
    if user
      token = create_token(user.id)
      render json: { token: token, user: user, foods: user.bookmark_foods }
    else
      render status: 404, json: { status: :bad_request }
    end
  end
end
