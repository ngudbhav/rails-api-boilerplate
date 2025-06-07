module Users
  class ProfilesController < ApplicationController
    def show
      ok(user: current_user)
    end

    def update
      current_user.update!(update_params)

      ok
    end

    private

    def update_params
      params.require(:user).permit(:name, :email_address)
    end
  end
end
