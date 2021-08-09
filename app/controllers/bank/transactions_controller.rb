# frozen_string_literal: true
module Bank
  class TransactionsController < ApplicationController
  before_action :authenticate

  def create
    result =
      BankOperations::Transaction::Create.new.call(
        user_id: current_account.id,
        email: transaction_params[:output_email],
        amount: transaction_params[:amount],
      )

    if result.success?
      store_retry_data(result.value!)
      redirect_to bank_account_url,
                  flash: {
                    success: 'Transaction was successfully created.',
                  }
    else
      redirect_to bank_account_url,
                  flash: {
                    danger: stringify_error(result.failure),
                  }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:bank_transaction).permit(:amount, :output_email)
  end
  end
end
