class ApplicationController < ActionController::API
  include ActionController::Cookies
  
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  private

  def record_invalid invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    @model_name = controller_name.classify
    render json: {errors: "#{@model_name} not found"}, status: :not_found
  end
end
