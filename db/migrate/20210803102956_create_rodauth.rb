class CreateRodauth < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'citext'

    create_table :accounts do |t|
      t.citext :email, null: false, index: { unique: true }
    end

    # Used if storing password hashes in a separate table (default)
    create_table :account_password_hashes do |t|
      t.foreign_key :accounts, column: :id
      t.string :password_hash, null: false
    end

    # Used by the remember me feature
    create_table :account_remember_keys do |t|
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
    end
  end
end
