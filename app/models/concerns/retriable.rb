# frozen_string_literal: true
module Retriable
  extend ActiveSupport::Concern

  included { has_many :idempotent_models, as: :retriable, dependent: :destroy }
end
