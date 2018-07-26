module RequestHelper
  def valid_signin(user)
    visit new_user_session_path
    fill_in 'Email',    with: user.email.upcase
    fill_in 'Password', with: user.password
    click_button "Log in"
  end
end
