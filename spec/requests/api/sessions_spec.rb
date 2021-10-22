require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/sessions/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
