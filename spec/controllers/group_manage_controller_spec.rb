require 'rails_helper'

RSpec.describe GroupManageController, type: :controller do

  describe "GET #group_leave" do
    it "returns http success" do
      get :group_leave
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #group_join" do
    it "returns http success" do
      get :group_join
      expect(response).to have_http_status(:success)
    end
  end

end
