class Bank::TransactionsController < ApplicationController
  before_action :authenticate

  def create
    bank_account = current_account.bank_account
    target_account =
      ::Account.find_by(email: bank_transaction_params[:output_email])
        &.bank_account

    @bank_transaction =
      BankOperations::Transaction::Create.new.(
        bank_account_id: bank_account.id,
        output_id: target_account.id,
        amount: bank_transaction_params[:amount],
      )

    respond_to do |format|
      if @bank_transaction.success?
        format.html do
          redirect_to bank_account_url,
                      notice: 'Transaction was successfully created.'
        end
        format.json do
          render :show, status: :created, location: @bank_transaction
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @bank_transaction.exception,
                 status: :unprocessable_entity
        end
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def bank_transaction_params
    params.require(:bank_transaction).permit(:amount, :status, :output_email)
  end
end
