class ApplicationController < ActionController::API
  def authenticate_request
    header = request.headers['Authorization']
    if header
      token = header.split(' ').last
    end

    begin
      #secret = ENV['RAILS_MASTER_KEY']  # Or use Rails.application.credentials if you're using credentials
      secret = Rails.application.credentials.secret_key_base
      decoded = JWT.decode(token, secret).first

      # Assuming the token contains user_id
      @current_user = User.find(decoded['user_id'])
      Rails.logger.info("Decoded JWT: #{decoded.inspect}")  # Log the decoded JWT for debugging purposes

    rescue JWT::ExpiredSignature => e
      Rails.logger.error("JWT Expired: #{e.message}")  # Log the exception message
      render json: { error: 'Token has expired', details: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      Rails.logger.error("JWT Decode Error: #{e.message}, Token: #{token}")  # Log the exception and the token
      render json: { error: 'JWT Auth Unauthorized', details: e.message, token: token }, status: :unauthorized
    rescue StandardError => e
      Rails.logger.error("Error during token authentication: #{e.message}")
      render json: { error: 'Internal server error', details: e.message }, status: :internal_server_error
    end
  end
end
