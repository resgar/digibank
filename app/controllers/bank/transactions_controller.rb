class Bank::TransactionsController < ApplicationController
  def create
    @bank_transaction = Bank::Transaction.new(bank_transaction_params)

    respond_to do |format|
      if @bank_transaction.save!
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
          render json: @bank_transaction.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def bank_transaction_params
    params
      .require(:bank_transaction)
      .permit(:amount, :status, :bank_account_id, :output_id)
  end
end
