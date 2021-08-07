module ApplicationHelper
  def retried_request?
    if idempotency_key.present?
      retried_operation_record = IdempotencyKey.find_by(key: idempotency_key)
      redirect_back(fallback_location: root_path) if retried_operation_record
    end
  end

  def store_retry_data(object)
    object.idempotency_keys.create(key: idempotency_key) if idempotency_key
  end

  private

  def idempotency_key
    params[:idempotency_key]
  end
end
