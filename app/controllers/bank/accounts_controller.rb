module Bank
  class AccountsController < ApplicationController
    def show
      @account = current_account.bank_account
    end
  end
end
