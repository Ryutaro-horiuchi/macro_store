module JwtToken
  extend ActiveSupport::Concern

  def create_token(user_id)
    valid_time = Time.now.to_i + 3600
    payload = { id: user_id, exp: valid_time }
    encode(payload)
  end
  
  def check_token(token)
    JWT.decode token, Rails.application.credentials.sercret_key_base 
  end
  
  private

  def encode(payload)
    JWT.encode payload, Rails.application.credentials.sercret_key_base 
  end
end

