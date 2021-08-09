# frozen_string_literal: true
require 'test_helper'

module Bank
  class TransactionsControllerTest < ActionDispatch::IntegrationTest
  include IntegrationHelperTest

  def setup
    @account = create(:bank_account).account
  end

  test 'should create transaction' do
    assert_difference('Bank::Transaction.count') do
      output_bank_account = create(:bank_account)

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

  test 'should fail when output account not found' do
    login(email: @account.email, password: @account.password)
    post bank_transactions_url,
         params: {
           bank_transaction: {
             amount: 20,
             output_email: 'invalid@example.com',
           },
         }

    # assert_redirected_to bank_account_url
  end
  end
end
