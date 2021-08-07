class Bank::Transaction < ApplicationRecord
  include Retriable

  belongs_to :bank_account, class_name: 'Bank::Account'
  belongs_to :output, class_name: 'Bank::Account', foreign_key: :output_id

  enum status: %i[pending running done]

  validates :amount, presence: true

  def update_balances
    return unless self.pending?

    Bank::Transaction.transaction do
      self.running!
      bank_account.lock!
      output.lock!
      bank_account.balance -= amount
      bank_account.save!
      output.balance += amount
      output.save!
      self.done!
    end
    self
  end
end
