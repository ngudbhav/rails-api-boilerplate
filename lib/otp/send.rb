require_relative "./errors"

module Otp
  # This class is responsible for sending a verification request to a specified phone number.
  # It initializes with a resource (which should respond to `verifications`) and a phone number.
  # It raises errors if the resource is invalid or the phone number is not valid.
  # It creates a verification record when the `call` method is invoked.
  class Send
    def initialize(resource, phone_number)
      @resource = resource
      @phone_number = phone_number

      raise Otp::Errors::InvalidResourceError unless @resource.respond_to?(:verifications)
      raise Otp::Errors::InvalidPhoneNumberError unless Phonelib.valid?(@phone_number)
    end

    # This method creates a verification record for the given phone number.
    # It uses the `verifications` association of the resource to create a new record.
    # @return [UserVerification] The created user verification record.
    def call
      @resource.verifications.create!(phone_number: @phone_number)
    end
  end
end
