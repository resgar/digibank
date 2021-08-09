# frozen_string_literal: true
class Account < ApplicationRecord
  include Rodauth::Rails.model

  has_one :bank_account, class_name: 'Bank::Account', dependent: :destroy

  validates :email, :password, presence: true

  validates :email, uniqueness: true
end
