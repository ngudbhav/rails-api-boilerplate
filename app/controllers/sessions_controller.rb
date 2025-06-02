class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render json: { message: "Try again later." }, status: :too_many_requests }

  before_action :set_user, only: %i[ create ]

  def create
    if @user.authenticate_by_phone(create_params.dig(:otp))
      start_new_session_for @user
      token = JwtAuthenticate.encode(user_id: @user.id)
      ok(token: token)
    else
      bad_request(Otp::Errors::InvalidOtpError.new.message)
    end
  end

  def destroy
    terminate_session

    ok
  end

  private

  def create_params
    params.expect!(:phone_number, :otp)

    {
      phone_number: params[:phone_number],
      otp: params[:otp]
    }
  end

  def set_user
    @user = User.find_by(phone_number: create_params.dig(:phone_number)) ||
      UserVerification.unverified.where(phone_number: create_params.dig(:phone_number)).last&.user

    request_authentication unless @user.present?
  end
end
