require 'test_helper'

class TransactionTest < ActionDispatch::IntegrationTest
  include IntegrationHelperTest

  def setup
    @bank_account = create(:bank_account)
  end

  test 'transaction with repeated idempotency_key' do
    output_bank_account = create(:bank_account, :output)

    login(
      email: @bank_account.account.email,
      password: @bank_account.account.password,
    )

    post bank_transactions_url,
         params: {
           bank_transaction: {
             amount: 20,
             output_email: output_bank_account.account.email,
           },
           idempotency_key: 'foo',
         }

    assert_no_difference('output_bank_account.reload.balance') do
      post bank_transactions_url,
           params: {
             bank_transaction: {
               amount: 20,
               output_email: output_bank_account.account.email,
             },
             idempotency_key: 'foo',
           }
    end
  end

  test 'transaction with different idempotency_key' do
    output_bank_account = create(:bank_account, :output)

    login(
      email: @bank_account.account.email,
      password: @bank_account.account.password,
    )

    post bank_transactions_url,
         params: {
           bank_transaction: {
             amount: 20,
             output_email: output_bank_account.account.email,
           },
           idempotency_key: 'foo',
         }

    assert_difference('output_bank_account.reload.balance', 20) do
      post bank_transactions_url,
           params: {
             bank_transaction: {
               amount: 20,
               output_email: output_bank_account.account.email,
             },
             idempotency_key: 'bar',
           }
    end
  end
end
