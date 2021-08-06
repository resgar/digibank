module BankContracts
  module Transaction
    class Create < Dry::Validation::Contract
      params do
        required(:amount).value(:float)
        required(:bank_account_id).value(:integer)
        required(:output_id).value(:integer)
      end
    end
  end
end
