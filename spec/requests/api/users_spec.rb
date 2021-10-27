require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/users/create"
      expect(response).to have_http_status(:success)
    end
  end

end
