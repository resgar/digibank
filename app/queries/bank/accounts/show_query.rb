# frozen_string_literal: true
module Bank
  module Accounts
    class ShowQuery
      attr_reader :object

      def initialize(record)
        @object = record
      end

      # The transaction input is the account from which the transaction was sent.
      def input_transactions
        object.input_transactions.order(created_at: :desc)
      end

      # The transaction output is the account to which the money was sent.
      def output_transactions
        object.output_transactions.order(created_at: :desc)
      end
    end
  end
end
