module Bank
  class AccountsController < ApplicationController
    before_action :authenticate

    def show
      @account = current_account.bank_account
      @input_transactions = @account.input_transactions.order(created_at: :desc)
      @output_transactions =
        @account.output_transactions.order(created_at: :desc)
      @transaction = Bank::Transaction.new
      @idempotency_key = SecureRandom.uuid
    end
  end
end
