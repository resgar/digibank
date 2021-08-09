# frozen_string_literal: true
module Bank
  class Transaction < ApplicationRecord
    include Retriable

    belongs_to :bank_account,
               class_name: 'Bank::Account',
               inverse_of: :input_transactions
    belongs_to :output,
               class_name: 'Bank::Account',
               inverse_of: :output_transactions

    enum status: { pending: 0, processing: 1, done: 2, failed: 3 }

    validates :amount, presence: true

    def update_balances
      return unless pending?

      Bank::Transaction.transaction do
        processing!
        bank_account.lock!
        bank_account.balance -= amount
        bank_account.save!
        output.lock!
        output.balance += amount
        output.save!
      end
      self
    end
  end
end
