require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe '#home' do
    subject(:response) do
      get :home
    end

    it 'should get home' do
      expect(response).to have_http_status(:success)
      expect(response.body).to match /#{base_title}/
    end
  end

  describe '#help' do
    subject(:response) do
      get :help
    end

    it 'should get help' do
      expect(response).to have_http_status(:success)
      expect(response.body).to match /Help | #{base_title}/
    end
  end

  describe '#about' do
    subject(:response) do
      get :about
    end

    it 'should get about' do
      expect(response).to have_http_status(:success)
      expect(response.body).to match /About | #{base_title}/
    end
  end

  describe '#contact' do
    subject(:response) do
      get :contact
    end

    it 'should get content' do
      expect(response).to have_http_status(:success)
      expect(response.body).to match /Content | #{base_title}/
    end
  end
end
