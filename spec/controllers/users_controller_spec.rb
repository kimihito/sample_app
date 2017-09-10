require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  fixtures :users
  let(:user) { users(:michael) }
  let(:other_user) { users(:archer) }

  describe '#index' do
    subject(:response) do
      get :index
    end

    it 'should redirect index when not logged in' do
      expect(response).to redirect_to login_url
    end
  end

  describe '#destroy' do
    subject(:response) do
      delete :destroy, params: { id: user.id }
    end

    it 'should redirect destroy when not logged in' do
      expect { response }.not_to change { User.count }
      expect(response).to redirect_to login_url
    end

    context 'non admin' do
      before { log_in_as(other_user) }

      it 'should redirect destroy when logged in' do
        expect { response }.not_to change { User.count }
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "/users/:id/following" do
    subject(:response) do
      get :following, params: { id: user.id }
    end

    it 'should redirect following when not logged in' do
      expect(response).to redirect_to login_url
    end
  end

  describe '/users/:id/followers' do
    subject(:response) do
      get :followers, params: { id: user.id }
    end

    it 'should redirect followers when not logged in' do
      expect(response).to redirect_to login_url
    end
  end
end
