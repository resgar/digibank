class Account < ApplicationRecord
  include Rodauth::Rails.model

  has_one :bank_account, class_name: 'Bank::Account', dependent: :destroy

  before_create :build_default_bank_account

  private

  def build_default_bank_account
    build_bank_account
    true
  end
end
