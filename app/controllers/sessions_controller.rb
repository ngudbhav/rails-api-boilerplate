class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render json: { message: "Try again later." }, status: :too_many_requests }

  before_action :set_user, only: %i[ create ]

  def create
    authenticated_user = if email_login?
      @user.authenticate_by_email(params[:password])
    else
      @user.authenticate_by_phone(params[:otp])
    end

    if authenticated_user
      start_new_session_for @user
      ok(token: JwtAuthenticate.encode(user_id: @user.id))
    else
      bad_request(email_login? ? "Invalid email or password" : Otp::Errors::InvalidOtpError.new.message)
    end
  end

  def destroy
    terminate_session

    ok
  end

  private

  def email_login?
    params[:email_address].present?
  end

  def set_user
    @user = if email_login?
      User.find_by(email_address: params[:email_address])
    else
      User.find_by(phone_number: params[:phone_number]) ||
        UserVerification.unverified.where(phone_number: params[:phone_number]).last&.user
    end

    request_authentication unless @user.present?
  end
end
