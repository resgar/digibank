require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  self.use_instantiated_fixtures = :no_instances

  def setup
    @user = Account.create(email: 'account@example.com', password: 'password')
  end

  test 'login with valid email/invalid password' do
    get '/login'
    assert_select 'h2', 'Account Login'
    post '/login', params: { login: @user.email, password: 'invalid' }
    assert_select 'h2', 'Account Login'
    assert_not flash.empty?
    get '/login'
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get '/login'
    post '/login', params: { login: @user.email, password: 'password' }
    assert_redirected_to '/'
    follow_redirect!
    assert_select 'h1', 'Accounts'
    assert_select 'a[href=?]', '/login', count: 0
    assert_select 'a[href=?]', '/logout'
    post '/logout'
    assert_redirected_to '/'

    # Simulate a user clicking logout in a second window.
    post '/logout'
    follow_redirect!
    assert_select 'a[href=?]', '/login'
    assert_select 'a[href=?]', '/logout', count: 0
  end
end
