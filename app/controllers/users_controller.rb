class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render json: { message: "Try again later." }, status: :too_many_requests }

  before_action :set_user, only: %i[ create ]

  def create
    if @user.save
      @user.send_otp(user_params[:phone_number]) if @user.phone_number.present?
      ok
    else
      bad_request(@user.errors.full_messages.join(", "))
    end
  end

  private

  def set_user
    if user_params[:phone_number].present?
      @user = User.find_or_initialize_by(phone_number: user_params[:phone_number])
    else
      @user = User.new(user_params)
    end
  end

  def user_params
    params.require(:user).permit(:phone_number, :email_address, :password, :password_confirmation)
  end
end
