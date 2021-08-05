module Bank
  class Account < ApplicationRecord
    belongs_to :account

    validates :balance, presence: true
  end
end
