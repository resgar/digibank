class Bank::Transaction < ApplicationRecord
  include Retriable

  belongs_to :bank_account, class_name: 'Bank::Account'
  belongs_to :output, class_name: 'Bank::Account', foreign_key: :output_id

  enum status: %i[pending processing done failed]

  validates :amount, presence: true

  def update_balances
    return unless self.pending?

    Bank::Transaction.transaction do
      self.processing!
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
