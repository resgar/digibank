module Bank
  class Account < ApplicationRecord
    belongs_to :account, class_name: '::Account'
    has_many :input_transactions,
             class_name: 'Bank::Transaction',
             dependent: :destroy,
             foreign_key: :bank_account_id

    has_many :output_transactions,
             class_name: 'Bank::Transaction',
             dependent: :destroy,
             foreign_key: :output_id

    validates :balance,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0,
              }
  end
end
