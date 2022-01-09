class ApplicationController < ActionController::Base
  include Jwt
  protect_from_forgery with: :null_session
end
