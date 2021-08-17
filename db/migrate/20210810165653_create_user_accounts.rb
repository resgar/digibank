class CreateUserAccounts < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :account_password_hashes, :accounts
    remove_foreign_key :account_remember_keys, :accounts
    rename_table :accounts, :user_accounts
    rename_column :bank_accounts, :account_id, :user_account_id
    add_foreign_key :account_password_hashes, :user_accounts, column: :id
    add_foreign_key :account_remember_keys, :user_accounts, column: :id
  end
end
