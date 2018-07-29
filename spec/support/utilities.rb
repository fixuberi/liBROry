module RequestHelper
  def valid_signin(user)
    visit new_user_session_path
    fill_in 'Email',    with: user.email.upcase
    fill_in 'Password', with: user.password
    click_button "Log in"
  end

  def update_author_with(name)
    fill_in 'author_name', with: name
    click_button "Update author"
  end

  def update_group_with(name)
    fill_in 'group_name', with: name
    click_button "Update group"
  end

  def check_in(object)
    check 'book_'+object.class.to_s.downcase.pluralize+"_#{object.id}"
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end
