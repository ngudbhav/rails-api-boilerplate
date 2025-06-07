class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render json: { message: "Try again later." }, status: :too_many_requests }

  before_action :set_user, only: %i[ create ]

  def create
    if @user.save
      @user.send_otp(user_phone_number)
      ok
    else
      bad_request(@user.errors.full_messages.join(", "))
    end
  end

  private

  def user_phone_number
    params.require(:user).expect!(:phone_number)
  end

  def set_user
    @user = User.find_or_initialize_by(phone_number: user_phone_number)
  end
end
