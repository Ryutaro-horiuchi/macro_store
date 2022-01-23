module LoginSupport
  def login(user)
    visit '/login'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: '12345678'
    click_button 'ログインする'
  end

  RSpec.configure do |config|
    config.include LoginSupport
  end
end