class CreateBankTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_transactions do |t|
      t.float :amount
      t.integer :status, default: 0, limit: 1
      t.references :bank_account, null: false, foreign_key: true
      t.references :output,
                   null: false,
                   foreign_key: {
                     to_table: :bank_accounts,
                   }

      t.timestamps
    end
  end
end
