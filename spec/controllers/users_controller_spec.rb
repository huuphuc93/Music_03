require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user){FactoryBot.create :user}
  # before(%i(edit update destroy)) do
  #   correct_user, id: user.id
  # end
  
  describe "GET #show" do
    it "render template show" do
      get :show, params: {id: user.id}
      expect(response).to render_template :show
    end
    
    it ""
  end
end