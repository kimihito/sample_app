require 'rails_helper'

describe User, type: :model do
  fixtures :users

  let(:user) { User.new(name: name, email: email, password: password, password_confirmation: password_confirmation) }
  let(:name) { 'Example User' }
  let(:email) { 'user@example.com' }
  let(:password) { 'foobar' }
  let(:password_confirmation) { password }

  subject { user }

  it { is_expected.to be_valid }

  context 'name is empty' do
    let(:name) { ' ' }
    it { is_expected.to be_invalid }
  end

  context 'name is too long' do
    let(:name) { 'a' * 51 }
    it { is_expected.to be_invalid }
  end

  context 'email is empty' do
    let(:email) { ' ' }
    it { is_expected.to be_invalid }
  end

  context 'email is too long' do
    let(:email) { 'a' * 244 + '@example.com' }
    it { is_expected.to be_invalid }
  end

  context 'check email validation' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      let(:email) { valid_address }
      it { is_expected.to be_valid }
    end
  end

  context 'duplicate email addresses' do
    before do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      duplicate_user.save
    end

    it { is_expected.to be_invalid }
  end

  context 'lower-case email addresses' do
    let(:mixed_case_email) {'Foo@ExAMPle.CoM' }
    subject { user.email }
    before do
      user.email = mixed_case_email
      user.save
    end

    it { is_expected.to eq mixed_case_email.downcase }
  end

  context 'blank password' do
    let(:password) { ' ' }
    it { is_expected.to be_invalid }
  end

  context 'minimum legth password' do
    let(:password) { 'a' * 5 }
    it { is_expected.to be_invalid }
  end

  describe '#authenticated?' do
    subject { user.authenticated?(:remember, '') }
    it { is_expected.to eq false }
  end

  describe 'associated microposts' do
    before do
      user.save
      user.microposts.create!(content: 'Lorem lpsum')
    end

    subject { user.destroy }

    it { expect { subject }.to change { Micropost.count }.by(-1) }
  end
end
