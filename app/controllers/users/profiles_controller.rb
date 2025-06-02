module Users
  class ProfilesController < ApplicationController
    def show
      ok
    end

    def update
      current_user.update!(update_params)

      ok
    end

    private

    def update_params
      params.permit(:name, :email_address)
    end
  end
end
