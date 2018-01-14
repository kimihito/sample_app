require 'rails_helper'

RSpec.describe 'User login', js: true do
  fixtures :all

  describe 'login with invalid information' do
    let!(:user) { users(:michael) }

    it do
      visit login_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: ''
      click_button 'Log in'
      expect(current_path).to eq login_path
      expect(page).to have_content('Invalid email/password combination')
    end
  end

  describe 'login with valid information followed by logout' do
    let!(:user) { users(:michael) }
    it do
      visit login_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: 'password'
      click_button 'Log in'
      expect(current_path).to eq user_path(user)
      click_link('Account')
      click_link('Log out')
      expect(current_path).to eq root_path
    end
  end

  describe 'login with remembering' do
    let!(:user) { users(:michael) }
    it do
      login_as(user, remember: true)
      expect(page.driver.browser.manage.cookie_named('remember_token')).not_to be_nil
    end
  end

  describe 'login without remembering' do
    let!(:user) { users(:michael) }
    it do
      login_as(user, remember: false)
      expect(page.driver.browser.manage.cookie_named('remember_token')).to be_nil
    end
  end
end