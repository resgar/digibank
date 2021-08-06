module BankOperations
  module Transaction
    class Create
      include Dry::Monads[:result]
      include Dry::Monads[:try]
      Dry::Validation.load_extensions(:monads)

      def call(params)
        validate(params).bind do |validate_params|
          Bank::Transaction.transaction do
            create_transaction(validate_params.to_h).bind do |transaction|
              update_balances(transaction)
            end
          end
        end
      end

      def validate(params)
        create_contract = BankContracts::Transaction::Create.new
        create_contract.(params).to_monad
      end

      def create_transaction(values)
        transaction = Bank::Transaction.create(values)

        return Failure(transaction.errors.to_hash) unless transaction.valid?
        Success(transaction)
      end

      def update_balances(transaction)
        Try() { transaction.update_balances }
      end
    end
  end
end
