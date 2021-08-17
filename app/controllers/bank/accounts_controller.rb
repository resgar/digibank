# frozen_string_literal: true
module Bank
  class AccountsController < ApplicationController
    before_action :authenticate

    def show
      @account_query =
        BanksService::Queries::ShowAccount.new(current_user.bank_account)
      @transaction = Bank::Transaction.new
    end
  end
end
