require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  fixtures :users
  describe 'account_activation' do
    let!(:user) { users(:michael) }
    let(:token) { User.new_token }
    before { user.activation_token = token }
    subject(:mail) do
      UserMailer.account_activation(user)
    end

    it { expect(mail.subject).to eq('Account activation') }
    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq(['noreply@example.com']) }
    it { expect(mail.body.encoded).to match(user.name)  }
    it { expect(mail.body.encoded).to match(user.activation_token)  }
    it { expect(mail.body.encoded).to match(CGI.escape(user.email)) }
  end

  describe 'password_reset' do
    let!(:user) { users(:michael) }
    let(:token) { User.new_token }
    before { user.reset_token = token }
    subject(:mail) do
      UserMailer.password_reset(user)
    end

    it { expect(mail.subject).to eq('Password reset') }
    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq(['noreply@example.com']) }
    it { expect(mail.body.encoded).to match(user.reset_token)  }
    it { expect(mail.body.encoded).to match(CGI.escape(user.email)) }
  end
end