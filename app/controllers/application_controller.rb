class ApplicationController < ActionController::Base
  include Jwt
  skip_before_action :verify_authenticity_token
end
