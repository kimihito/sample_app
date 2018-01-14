require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  fixtures :users

  describe '#new' do
    subject(:response) do
      get :new
    end
    it 'should get new' do
      expect(response).to have_http_status(:success)
    end
  end
end
