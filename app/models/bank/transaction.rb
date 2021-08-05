class Bank::Transaction < ApplicationRecord
  belongs_to :bank_account, class_name: 'Bank::Account'
  belongs_to :output, class_name: 'Bank::Account', foreign_key: :output_id

  validates :amount, presence: true
end
