require 'rails_helper'

RSpec.describe 'Edit user', js: true do
  fixtures :users

  before { login_as(user) }
  describe 'Unsuccessful edit' do
    let!(:user) { users(:michael) }
    subject do
      visit edit_user_path(user)
      fill_in 'user_email', with: 'foo@invalid'
      fill_in 'user_password', with: 'foo'
      fill_in 'user_password_confirmation', with: 'bar'
      click_button 'Save changes'
    end

    it 'should have errors' do
      subject
      expect(page).to have_css('.alert-danger')
    end
  end

  describe 'Successful edit when friendly forwarding' do
    let!(:user) { users(:michael) }
    let(:old_name) { user.name }
    let(:old_email) { user.email }
    let(:name) { 'Foo Bar' }
    let(:email) { 'foo@bar.com' }
    subject do
      visit edit_user_path(user)
      fill_in 'user_name', with: name
      fill_in 'user_email', with: email
      click_button 'Save changes'
    end

    it 'should change name' do
      expect { subject }.to change {
        user.reload.name
      }.from(old_name).to(name).and change {
        user.reload.email
      }.from(old_email).to(email)
    end
  end
end
