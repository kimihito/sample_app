require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  fixtures :users, :microposts
  describe '#create' do
    subject(:response) do
      post :create, params: { micropost: { content: 'Lorem ipsum' }}
    end

    it 'should redirect create when not logged in' do
      expect { response }.not_to change { Micropost.count }
      expect(response).to redirect_to login_url
    end
  end

  describe '#destroy' do
    let(:micropost) { microposts(:orange) }

    subject(:response) do
      delete :destroy, params: {  id: micropost.id  }
    end

    context 'user is not logged in' do
      it 'should redirect destry when not logged in' do
        expect { response }.not_to change { Micropost.count }
        expect(response).to redirect_to login_url
      end
    end

    context 'user is logged in' do
      let(:micropost) { microposts(:ants) }
      before { log_in_as(users(:michael)) }

      it 'should redirect destroy for wrong micropost' do
        expect { response }.not_to change { Micropost.count }
        expect(response).to redirect_to root_url
      end
    end

  end
end
