require 'test_helper'

class Bank::TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup { @bank_transaction = bank_transactions(:one) }

  test 'should create bank_transaction' do
    assert_difference('Bank::Transaction.count') do
      @source_account = bank_accounts(:one)
      @destination_account = bank_accounts(:two)

      post bank_transactions_url,
           params: {
             bank_transaction: {
               amount: @bank_transaction.amount,
               bank_account_id: @source_account.id,
               output_id: @destination_account.id,
               status: @bank_transaction.status,
             },
           }
    end

    assert_redirected_to bank_account_url
  end
end
