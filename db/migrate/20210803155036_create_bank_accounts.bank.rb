# This migration comes from bank (originally 20210803153416)
class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.float :balance, null: false, default: 0.0
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
