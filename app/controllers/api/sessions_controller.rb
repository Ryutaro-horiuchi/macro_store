class Api::SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password])
    if user
      token = create_token(user.id)
      render json: { token: token, user: user }
    else
      render json: user.errors, status: :bad_request
    end
  end

end
