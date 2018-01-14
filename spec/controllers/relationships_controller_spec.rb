require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  fixtures :relationships
  describe '#create' do
    subject(:response) do
      post :create, params: { relationship: { } }
    end

    it 'should require lgged-in user' do
      expect { response }.not_to change { Relationship.count }
      expect(response).to redirect_to login_url
    end
  end

  describe '#destroy' do
    let(:relationship) { relationships(:one) }
    subject(:response) do
      delete :destroy, params: { id: relationship.id }
    end

    it 'should require logged-in user' do
      expect { response }.not_to change { Relationship.count }
      expect(response).to redirect_to login_url
    end
  end
end
