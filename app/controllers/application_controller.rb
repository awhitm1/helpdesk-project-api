class ApplicationController < ActionController::API
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header 
    begin
      secret = ENV['RAILS_MASTER_KEY']
      decoded = JWT.decode(header, secret).first
      # decoded = JWT.decode(header, RAILS_MASTER_KEY).first
      @current_user = User.find(decoded['user_id'])
    rescue JWT::ExpiredSignature
      render json: {error: 'Token has expired'}, status: :unauthorized
    rescue JWT::DecodeError
      render json: {error: 'JWT Auth Unauthorized', header: header}, status: :unauthorized
    end
  end
end
