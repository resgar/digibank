module Bank
  module Accounts
    class ShowQuery
      attr_reader :object

      def initialize(record)
        @object = record
      end

      def input_transactions
        object.input_transactions.order(created_at: :desc)
      end

      def output_transactions
        object.output_transactions.order(created_at: :desc)
      end
    end
  end
end
