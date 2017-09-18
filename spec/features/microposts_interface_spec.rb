require 'rails_helper'

describe 'Micropost interface', type: :feature do
  fixtures :users, :microposts
  let(:user) { users(:michael) }

  before do
    page.set_rack_session(user_id: user.id)
    visit root_path
  end

  after do
    page.set_rack_session(user_id: nil)
    visit root_path
  end

  describe 'Create new micropost' do
    subject do
      visit root_path
      fill_in 'micropost_content', with: ''
      click_button 'Post'
      page
    end

    context 'Invalid transmission' do
      it { is_expected.to have_css('div#error_explanation') }
    end

    context 'Valid transmission' do
      let(:content) { 'This micropost really ties the room together' }
      it { expect { subject }.to change { Micropost.count }.by(1) }
      it { is_expected.to have_content(content) }
    end
  end

  describe 'Delete micropost' do
    subject do
      visit root_path
      click_link 'delete', match: :first
      page.driver.browser.switch_to.alert.accept
      page
    end
    it { expect { subject }.to change { Micropost.count}.by(-1) }
  end
end
