# frozen_string_literal: true
module BanksService
  module Commands
    class CreateTransaction
      include Dry::Monads[:result]
      include Dry::Monads[:try]
      include Dry::Monads[:maybe]
      Dry::Validation.load_extensions(:monads)

      def call(params)
        validate(params).bind do |validated_params|
          values = validated_params.to_h
          find_input_account(values[:user_id]).bind do |input_account|
            find_output_account(values[:email]).bind do |output_account|
              create_transaction(input_account, output_account, values[:amount])
                .bind { |transaction| update_balances(transaction) }
            end
          end
        end
      end

      private

      def validate(params)
        create_contract = Contracts::CreateTransaction.new
        create_contract.call(params).to_monad
      end

      def find_input_account(user_id)
        account = Bank::Account.find_by(user_account_id: user_id)
        Maybe(account).to_result { :input_account_not_found }
      end

      def find_output_account(email)
        account = User::Account.find_by(email: email)&.bank_account
        Maybe(account).to_result { :output_account_not_found }
      end

      def create_transaction(input_account, output_account, amount)
        transaction =
          Bank::Transaction.create(
            amount: amount,
            bank_account_id: input_account.id,
            output_id: output_account.id,
          )

        if transaction.valid?
          Success(transaction)
        else
          transaction.failed!
          Failure(transaction.errors.to_a.first)
        end
      end

      def update_balances(transaction)
        res = Try() { transaction.update_balances }
        res.error? ? transaction.failed! : transaction.done!
        res.to_result { :balance_update_failed }
      end
    end
  end
end
