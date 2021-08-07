class Account < ApplicationRecord
  include Rodauth::Rails.model

  has_one :bank_account, class_name: 'Bank::Account', dependent: :destroy

  validates_presence_of :email, :password

  validates :email, uniqueness: true
end
