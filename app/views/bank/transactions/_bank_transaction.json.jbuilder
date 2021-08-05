json.extract! bank_transaction, :id, :amount, :status, :bank_account_id, :output, :created_at, :updated_at
json.url bank_transaction_url(bank_transaction, format: :json)
