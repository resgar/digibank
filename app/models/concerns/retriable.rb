module Retriable
  extend ActiveSupport::Concern

  included { has_many :idempotency_keys, as: :retriable }
end
