module AuthHelper
  def auth_as(user)
    set_header(user)
    set_controller_current_user(user)
    user
  end

  def set_header(user)
    token = JwtAuthenticate.encode(user_id: user.id)
    request.headers.merge!(Authorization: "Bearer #{token}")
  end

  def set_controller_current_user(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
