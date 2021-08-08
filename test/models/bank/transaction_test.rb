require 'test_helper'

class Bank::TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = create(:transaction)
    @account = @transaction.bank_account
    @output_account = @transaction.output
  end

  test 'should update input account balances' do
    assert_difference('@account.reload.balance', -@transaction.amount) do
      @transaction.update_balances
    end
  end

  test 'should update output account balances' do
    assert_difference('@output_account.reload.balance', +@transaction.amount) do
      @transaction.update_balances
    end
  end

  test 'should not update the input balances multiple times' do
    assert_difference('@account.reload.balance', -@transaction.amount) do
      @transaction.update_balances
      @transaction.update_balances
    end
  end

  test 'should not update the output balances multiple times' do
    assert_difference('@output_account.reload.balance', +@transaction.amount) do
      @transaction.update_balances
      @transaction.update_balances
    end
  end

  test 'should not change balance when the input and output accounts are the same' do
    transaction = create(:transaction, :same_account)
    assert_no_difference('transaction.bank_account.reload.balance') do
      transaction.update_balances
    end
  end

  test 'should fail when transaction amount is more than balance' do
    transaction = create(:transaction, amount: 1000)
    assert_raises(ActiveRecord::RecordInvalid) { transaction.update_balances }
  end
end
