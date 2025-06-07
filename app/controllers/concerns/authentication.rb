module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  attr_reader :current_user

  private
  def authenticated?
    resume_session
  end

  def require_authentication
    resume_session || request_authentication
  end

  def resume_session
    Current.session ||= find_session
  end

  def find_session
    authenticate_request
  end

  def request_authentication
    unauthorized
  end

  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = JwtAuthenticate.decode(header)

    if decoded.present? && (user = User.find_by(id: decoded[:user_id]))
      start_new_session_for user
    else
      unauthorized
    end
  rescue => e
    Rails.logger.error e
    bad_request
  end

  def start_new_session_for(user)
    session = user.sessions.find_or_create_by!(user_agent: request.user_agent, ip_address: request.remote_ip)
    @current_user = user

    Current.session = session
  end

  def terminate_session
    Current.session.discard!
    @current_user = nil
  end
end
