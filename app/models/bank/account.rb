# frozen_string_literal: true
module Bank
  class Account < ApplicationRecord
    belongs_to :user_account,
               class_name: 'User::Account',
               inverse_of: :bank_account

    has_many :input_transactions,
             class_name: 'Bank::Transaction',
             dependent: :destroy,
             foreign_key: :bank_account_id,
             inverse_of: :bank_account

    has_many :output_transactions,
             class_name: 'Bank::Transaction',
             dependent: :destroy,
             foreign_key: :output_id,
             inverse_of: :output

    validates :balance,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0,
              }
  end
end
