class Api::BaseController < ApplicationController
  include ActionController::Serialization

  # rescue_from Api::RescuableError do |exception|
  #   response.headers['X-Error-Message'] = exception.message.to_s
  #   response.headers['X-Error-Code']    = exception.error_code.to_s
  #
  #   render json: {
  #     message: exception.message,
  #     error_code: exception.error_code,
  #   }, status: exception.http_status
  # end
end