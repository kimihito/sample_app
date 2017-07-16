require 'rails_helper'

describe Micropost, type: :model do
  fixtures :users, :microposts
  let(:user) { users(:michael) }
  let(:content) { 'a' * 140 }
  let(:micropost) { user.microposts.build(content: content) }

  subject { micropost }

  context 'user id is empty' do
    before { micropost.user_id = nil }
    it { is_expected.to be_invalid }
  end

  context 'content is empty' do
    let(:content) { ' ' }
    it { is_expected.to be_invalid }
  end

  context 'content is over 140 characters' do
    let(:content) { 'a' * 141 }
    it { is_expected.to be_invalid }
  end

  describe 'default_scope' do
    it { expect(Micropost.first).to eq microposts(:most_recent) }
  end
end
