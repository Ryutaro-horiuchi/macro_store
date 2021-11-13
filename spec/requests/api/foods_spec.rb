require 'rails_helper'

RSpec.describe "Api::Foods", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/api/foods/search"
      expect(response).to have_http_status(:success)
    end
  end

end
