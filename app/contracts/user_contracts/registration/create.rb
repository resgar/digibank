# frozen_string_literal: true
module UserContracts
  module Registration
    class Create < Dry::Validation::Contract
      params do
        required(:email).filled(:string)
        required(:password).filled(:string)
      end

      rule(:email) do
        key.failure('must meet requirements') unless value =~ URI::MailTo::EMAIL_REGEXP
      end

      rule(:password) do
        key.failure('must meet requirements') unless Rodauth::Rails.rodauth.password_meets_requirements?(value)
      end
    end
  end
end
