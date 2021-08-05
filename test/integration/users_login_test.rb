require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include IntegrationHelperTest

  def setup
    @user = Account.create(email: 'account@example.com', password: 'secret')
  end

  test 'login with valid email/invalid password' do
    get '/login'
    assert_select 'h2', 'Account Login'
    login(email: 'account@example.com', password: 'invalid')
    assert_select 'h2', 'Account Login'
    assert_not flash.empty?
    get '/login'
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get '/login'
    login(email: 'account@example.com', password: 'secret')
    assert_redirected_to '/'
    follow_redirect!
    assert_select 'h1', 'Dashbaord'
    assert_select 'a[href=?]', '/login', count: 0
    assert_select 'a[href=?]', '/logout'
    post '/logout'
    assert_redirected_to '/'
  end
end
