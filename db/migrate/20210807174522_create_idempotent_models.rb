class CreateIdempotentModels < ActiveRecord::Migration[6.1]
  def change
    create_table :idempotent_models do |t|
      t.string :key
      t.references :retriable, polymorphic: true
      t.timestamps
    end
  end
end
