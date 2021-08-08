module ApplicationHelper
  def retried_request?
    if current_idempotency_key.present?
      retried_operation_record =
        IdempotentModel.find_by(key: current_idempotency_key)
      redirect_back(fallback_location: root_path) if retried_operation_record
    end
  end

  def store_retry_data(object)
    if current_idempotency_key
      object.idempotent_models.create(key: current_idempotency_key)
    end
  end

  def new_idempotentcy_key
    IdempotentModel.generate_key
  end

  def stringify_error(error_symbol)
    error_symbol.to_s.gsub('_', ' ').capitalize
  end

  private

  def current_idempotency_key
    params[:idempotency_key]
  end
end
