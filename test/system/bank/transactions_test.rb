require "application_system_test_case"

class Bank::TransactionsTest < ApplicationSystemTestCase
  setup do
    @bank_transaction = bank_transactions(:one)
  end

  test "visiting the index" do
    visit bank_transactions_url
    assert_selector "h1", text: "Bank/Transactions"
  end

  test "creating a Transaction" do
    visit bank_transactions_url
    click_on "New Bank/Transaction"

    fill_in "Amount", with: @bank_transaction.amount
    fill_in "Bank account", with: @bank_transaction.bank_account_id
    fill_in "Output", with: @bank_transaction.output
    fill_in "Status", with: @bank_transaction.status
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "updating a Transaction" do
    visit bank_transactions_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @bank_transaction.amount
    fill_in "Bank account", with: @bank_transaction.bank_account_id
    fill_in "Output", with: @bank_transaction.output
    fill_in "Status", with: @bank_transaction.status
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Transaction" do
    visit bank_transactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transaction was successfully destroyed"
  end
end
