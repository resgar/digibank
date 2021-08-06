require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'should create the bank account of the user' do
    user = ::Account.create!(email: 'account@example.com', password: 'secret')
    assert_not_nil user.bank_account
  end
end
