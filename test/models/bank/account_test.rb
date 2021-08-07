require 'test_helper'

module Bank
  class AccountTest < ActiveSupport::TestCase
    test 'should be valid with a positive balance' do
      bank_account = build(:bank_account, balance: 100)
      assert bank_account.valid?
    end

    test 'should not be valid with a negative balance' do
      bank_account = build(:bank_account, balance: -100)
      assert bank_account.invalid?
    end
  end
end
