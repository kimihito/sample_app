require 'rails_helper'

RSpec.describe 'user signup', type: :feature do
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'invalid signup infomation' do
    it do
      visit signup_path
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: 'user@invalid'
      fill_in 'user_password', with: 'foo'
      fill_in 'user_password_confirmation', with: 'bar'
      click_button 'Create my account'

      expect(page).to have_css('div#error_explanation')
      expect(page).to have_css('div.field_with_errors')
    end
  end

  describe 'valid signup information with account activation' do
    subject do
      visit signup_path
      fill_in 'user_name', with: 'Example User'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Create my account'
    end

    it { expect { subject }.to change { User.count }.by(1).and change { ActionMailer::Base.deliveries.size }.by(1) }

    it do
      subject
      visit login_path
      fill_in 'session_email', with: 'user@example.com'
      fill_in 'session_password', with: 'password'
      click_button 'Log in'

      expect(current_path).to eq root_path
      expect(page).to have_content('Account not activated.Check your email for the activation link.')
    end
  end
end