require 'test_helper'

module Bank
  class AccountTest < ActiveSupport::TestCase
    def setup
      @user = ::Account.create(email: 'account@example.com', password: 'secret')
    end

    test 'should be valid with a positive balance' do
      account = @user.create_bank_account(balance: 5)
      assert account.valid?
    end

    test 'should not be valid with a negative balance' do
      account = @user.create_bank_account(balance: -5)

      assert account.invalid?
    end
  end
end
