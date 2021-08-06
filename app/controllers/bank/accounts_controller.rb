module Bank
  class AccountsController < ApplicationController
    before_action :authenticate

    def show
      @account = current_account.bank_account
    end
  end
end
