require 'rails_helper'

describe Relationship, type: :model do
  fixtures :users
  let(:follower_id) { users(:michael).id }
  let(:followed_id) { users(:archer).id }

  let(:relationship) { Relationship.new(follower_id: follower_id, followed_id: followed_id) }
  subject { relationship }

  it { is_expected.to be_valid }

  context 'empty follower_id' do
    let(:follower_id) { nil }
    it { is_expected.to be_invalid }
  end

  context 'empty followed_id' do
    let(:followed_id) { nil }
    it { is_expected.to be_invalid }
  end
end
