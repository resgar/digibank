class Bank::Transaction < ApplicationRecord
  belongs_to :bank_account, class_name: 'Bank::Account'
  belongs_to :output, class_name: 'Bank::Account', foreign_key: :output_id

  validates :amount, presence: true

  def update_balances
    Bank::Transaction.transaction do
      bank_account.lock!
      output.lock!
      bank_account.balance -= amount
      bank_account.save!
      output.balance += amount
      output.save!
    end
  end
end
