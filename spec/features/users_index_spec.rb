require 'rails_helper'

RSpec.describe 'Edit user', js: true do
  fixtures :users

  let!(:admin) { users(:michael) }
  let!(:no_admin) { users(:archer) }

  describe 'index as admin includeing pagination and delete links' do
    before { login_as(admin) }
    it 'should include user link' do
      visit users_path
      first_page_of_users = User.paginate(page: 1)
      first_page_of_users.each do |user|
        expect(page).to have_link(user.name, href: user_path(user))
      end
    end

    it 'should delete non admin user' do
      visit users_path
      expect {
        find_link(text: 'delete', href: user_path(no_admin)).click
      }.to change { User.count }.by(-1)
    end
  end
end
