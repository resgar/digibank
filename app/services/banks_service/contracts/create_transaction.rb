# frozen_string_literal: true
module BanksService
  module Contracts
    class CreateTransaction < Dry::Validation::Contract
      params do
        required(:amount).value(:float)
        required(:user_id).value(:integer)
        required(:email).filled(:string)
      end

      rule(:amount) { key.failure('must be positive') if value.negative? }
    end
  end
end
