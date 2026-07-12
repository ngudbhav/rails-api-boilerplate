module Users
  # This module provides methods for authenticating users via email and password.
  module EmailAuthenticate
    # Authenticates the user with the provided password.
    # @param password [String] The password to verify.
    # @return [User, false] Returns the user if authentication is successful, otherwise returns false.
    def authenticate_by_email(password)
      authenticate(password) || false
    end
  end
end
