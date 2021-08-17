class User::Account < ApplicationRecord
  include Rodauth::Rails.model

  has_one :bank_account,
          class_name: 'Bank::Account',
          foreign_key: :user_account_id,
          inverse_of: :user_account,
          dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
