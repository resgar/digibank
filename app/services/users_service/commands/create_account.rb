# frozen_string_literal: true
module UsersService
  module Commands
    class CreateAccount
      include Dry::Monads[:result]
      Dry::Validation.load_extensions(:monads)

      def call(params)
        validate(params).bind do |validated_params|
          User::Account.transaction do
            create_user(validated_params.to_h).fmap(&:create_bank_account)
          end
        end
      end

      private

      def validate(params)
        create_contract = Contracts::CreateAccount.new
        create_contract.call(params).to_monad
      end

      def create_user(validated_params)
        user =
          User::Account.create(
            email: validated_params[:email],
            password: validated_params[:password],
          )
        user.valid? ? Success(user) : Failure(user)
      end
    end
  end
end
