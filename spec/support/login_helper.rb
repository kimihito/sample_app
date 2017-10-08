module LoginHelper
  def log_in_as(user)
    session[:user_id] = user.id
  end

  def login_as(user)
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: 'password'
    click_button 'Log in'
  end
end
