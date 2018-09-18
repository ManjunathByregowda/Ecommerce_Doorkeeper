class Api::V1::BaseController < ApplicationController

  protect_from_forgery with: :null_session
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from ::ActionController::UnknownFormat, with: :error_occurred

  # include Pundit
  # protect_from_forgery with: :null_session
  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from ::ActionController::RoutingError, with: :error_occurred
  # rescue_from ::ActionController::UnknownFormat, with: :error_occurred
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  
  private

  def current_token
    Doorkeeper::AccessToken.find_by(token: params[:access_token])
  end

  def current_user
    User.find(current_token.resource_owner_id) if current_token.present?
  end

  def authorize_application
    @app = Doorkeeper::Application.find_by(uid: params[:app_id], secret: params[:app_secret])
    return 404 if @app.blank?
  end

  def user_not_authorized
    render json: {message: 'Not Authorized', ok: false}.to_json, status: 403
  end

  def record_not_found(exception)
    render json: {message: exception.message, ok: false}.to_json, status: 404
    return
  end

  def error_occurred(exception)
    render json: {message: exception.message, ok: false}.to_json, status: 500
    return
  end

end
