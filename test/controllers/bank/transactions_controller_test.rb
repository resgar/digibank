require 'test_helper'

class Bank::TransactionsControllerTest < ActionDispatch::IntegrationTest
  include IntegrationHelperTest

  def setup
    @user = ::Account.create(email: 'account@example.com', password: 'secret')
    @user.create_bank_account(balance: 100)
  end

  test 'should create transaction' do
    assert_difference('Bank::Transaction.count') do
      target_user =
        ::Account.create(email: 'target@example.com', password: 'secret')

      login(email: 'account@example.com', password: 'secret')

      post bank_transactions_url,
           params: {
             bank_transaction: {
               amount: 20,
               output_email: target_user.email,
             },
           }
    end

    assert_redirected_to bank_account_url
  end
end
