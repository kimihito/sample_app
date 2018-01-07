require 'rails_helper'

RSpec.describe 'Edit user', js: true do
  fixtures :users
  let!(:admin) { users(:michael) }
  let!(:non_admin) { users(:archer) }

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
        page.accept_confirm do
          find_link(text: 'delete', href: user_path(non_admin)).click
        end
      }.to change { User.all.size }.by(-1)
    end
  end

  describe 'index as non-admin' do
    before { login_as(non_admin) }
    it 'should not have delete link' do
      visit users_path
      expect(page).to have_no_link('delete')
    end
  end
end
