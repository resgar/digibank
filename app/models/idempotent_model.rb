# frozen_string_literal: true
class IdempotentModel < ApplicationRecord
  belongs_to :retriable, polymorphic: true

  def self.generate_key
    SecureRandom.uuid
  end

  def generate_key
    self.key = self.class.generate_key
  end
end
