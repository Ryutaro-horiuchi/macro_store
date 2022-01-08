module Jwt
  extend ActiveSupport::Concern
  require 'jwt'

  def create_token(user_id)
    valid_time = Time.now.to_i + 3600
    payload = { id: user_id, exp: valid_time }
    encode(payload)
  end

  def current_user
    return @current_user if @current_user
    return unless bearer_token

    payload = decode(bearer_token)
    @current_user ||= User.find(payload[0]["id"])
  rescue JWT::ExpiredSignature
    nil
  end

  def bearer_token
    pattern = /^Bearer /
    header = request.headers['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end

  def authenticate!
    return if current_user

    head :unauthorized
  end

  private

  def encode(payload)
    JWT.encode payload, Rails.application.credentials.secret_key_base, 'HS256'
  end

  def decode(token)
    JWT.decode token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' }
  end
end
