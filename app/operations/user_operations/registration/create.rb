# frozen_string_literal: true
module UserOperations
  module Registration
    class Create
      include Dry::Monads[:result]
      Dry::Validation.load_extensions(:monads)

      def call(params)
        validate(params).bind do |validated_params|
          ::Account.transaction do
            create_user(validated_params.to_h).fmap(&:create_bank_account)
          end
        end
      end

      private

      def validate(params)
        create_contract = UserContracts::Registration::Create.new
        create_contract.call(params).to_monad
      end

      def create_user(validated_params)
        user =
          ::Account.create(
            email: validated_params[:email],
            password: validated_params[:password],
          )
        user.valid? ? Success(user) : Failure(user)
      end
    end
  end
end
