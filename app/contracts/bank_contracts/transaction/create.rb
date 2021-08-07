module BankContracts
  module Transaction
    class Create < Dry::Validation::Contract
      params do
        required(:amount).value(:float)
        required(:user_id).value(:integer)
        required(:email).filled(:string)
      end
    end
  end
end
