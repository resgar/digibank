module Bank
  class Account < ApplicationRecord
    belongs_to :account, class_name: '::Account'
    has_many :transactions,
             class_name: 'Bank::Transaction',
             dependent: :destroy,
             foreign_key: :bank_account_id

    validates :balance, presence: true
    validates :balance, numericality: { greater_than_or_equal_to: 0 }
  end
end
