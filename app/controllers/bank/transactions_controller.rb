class Bank::TransactionsController < ApplicationController
  before_action :authenticate

  def create
    transaction =
      BankOperations::Transaction::Create.new.(
        user_id: current_account.id,
        email: transaction_params[:output_email],
        amount: transaction_params[:amount],
      )

    if transaction.success?
      store_retry_data(transaction.value!)
      redirect_on_success
    else
      @account = current_account.bank_account
      render 'bank/accounts/show', status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:bank_transaction).permit(:amount, :output_email)
  end

  def redirect_on_success
    redirect_to bank_account_url,
                flash: {
                  success: 'Transaction was successfully created.',
                }
  end
end
