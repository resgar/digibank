require 'test_helper'

class Bank::TransactionsControllerTest < ActionDispatch::IntegrationTest
  include IntegrationHelperTest

  def setup
    @account = create(:bank_account).account
  end

  test 'should create transaction' do
    assert_difference('Bank::Transaction.count') do
      output_bank_account = create(:bank_account, :output)

      login(email: @account.email, password: @account.password)

      post bank_transactions_url,
           params: {
             bank_transaction: {
               amount: 20,
               output_email: output_bank_account.account.email,
             },
           }
    end

    assert_redirected_to bank_account_url
  end
end
