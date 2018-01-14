require 'rails_helper'

RSpec.describe 'User profile', js: true do
  fixtures :all
  describe 'displaying profile' do
    let!(:user) { users(:michael) }
    subject do
      visit user_path(user)
      page
    end

    it do
      expect(subject).to have_title("#{user.name} | Ruby on Rails Tutorial Sample App")
      expect(subject).to have_content(user.microposts.count.to_s)
      expect(subject).to have_selector(:css, 'h1>img.gravatar')
      expect(subject).to have_selector(:css, 'div.pagination')
      user.microposts.paginate(page: 1).each do |micropost|
        expect(subject).to have_content(micropost.content)
      end
    end
  end
end