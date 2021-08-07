class CreateIdempotencyKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :idempotency_keys do |t|
      t.string :key
      t.references :retriable, polymorphic: true
      t.timestamps
    end
  end
end
