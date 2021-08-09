# frozen_string_literal: true
module Bank
  class AccountsController < ApplicationController
    before_action :authenticate

    def show
      @account_query =
        Bank::Accounts::ShowQuery.new(current_account.bank_account)
      @transaction = Bank::Transaction.new
    end
  end
end
