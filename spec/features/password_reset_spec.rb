require 'rails_helper'

RSpec.describe 'PasswordReset', type: :feature do
  fixtures :users
  let(:user) { users(:michael) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'invalid request' do
    # visit new_password_reset_path
  end
end
