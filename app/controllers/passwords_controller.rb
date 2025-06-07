class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ update ]

  def create
    if (user = User.find_by(email_address: params[:email_address]))
      PasswordsMailer.reset(user).deliver_later
    end

    ok
  end

  def update
    if @user.update(params.require(:user).permit(:password, :password_confirmation))

      ok
    else
      head :not_acceptable
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])

      raise ActiveRecord::RecordNotFound unless @user.present?
    rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveRecord::RecordNotFound
      request_authentication
    end
end
