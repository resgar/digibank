require 'test_helper'

class Bank::TransactionTest < ActiveSupport::TestCase
  test 'should update balances' do
    user = ::Account.create(email: 'account@example.com', password: 'secret')
    user.create_bank_account(balance: 100)

    target_user =
      ::Account.create(email: 'another@example.com', password: 'secret')

    transaction =
      Bank::Transaction.create(
        bank_account_id: user.bank_account.id,
        output_id: target_user.bank_account.id,
        amount: 20,
      )

    assert_difference 'user.bank_account.reload.balance', -20 do
      transaction.update_balances
    end

    assert_difference 'target_user.bank_account.reload.balance', +20 do
      transaction.update_balances
    end
  end
end
