class IdempotencyKey < ApplicationRecord
  belongs_to :retriable, polymorphic: true
end
