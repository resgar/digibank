module Retriable
  extend ActiveSupport::Concern

  included { has_many :idempotent_models, as: :retriable }
end
