require 'test_helper'

module Bank
  class AccountTest < ActiveSupport::TestCase
    test 'the truth' do
      user =
        ::Account.create(email: 'account@example.com', password: 'password')
      assert_not_nil user.bank_account
    end
  end
end
