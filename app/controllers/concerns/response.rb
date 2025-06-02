module Response
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from ActionController::ExpectedParameterMissing, with: :bad_request
  end

  private

  def ok(json = {})
    if json.present?
      render json: json, status: :ok
    else
      head :ok
    end
  end

  def bad_request(error = "")
    if error.present?
      render json: error, status: :bad_request
    else
      head :bad_request
    end
  end

  def unauthorized(error = "")
    if error.present?
      render json: error, status: :unauthorized
    else
      head :unauthorized
    end
  end
end
