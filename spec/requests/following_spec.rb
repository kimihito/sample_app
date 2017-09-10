require 'rails_helper'

RSpec.describe 'Following', type: :feature do
  fixtures :users
  let(:user) { users(:michael) }
  let(:other) { users(:archer) }

  before { page.set_rack_session(user_id: user.id) }
  after { page.set_rack_session(user_id: nil) }

  describe 'following page' do
    subject do
      visit following_user_path(user)
      page
    end

    it 'should not be empty' do
      subject
      expect(user.following.empty?).to be_falsy
    end

    it 'should have following count' do
      expect(subject).to have_content(user.following.count)
    end
  end
end
