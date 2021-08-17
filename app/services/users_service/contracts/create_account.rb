# frozen_string_literal: true
module UsersService
  module Contracts
    class CreateAccount < Dry::Validation::Contract
      params do
        required(:email).filled(:string)
        required(:password).filled(:string)
      end

      rule(:email) do
        unless value =~ URI::MailTo::EMAIL_REGEXP
          key.failure('must meet requirements')
        end
      end

      rule(:password) do
        unless Rodauth::Rails.rodauth.password_meets_requirements?(value)
          key.failure('must meet requirements')
        end
      end
    end
  end
end
