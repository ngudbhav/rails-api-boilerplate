require_relative "./errors"

module Otp
  class Send
    def initialize(resource, phone_number)
      @resource = resource
      @phone_number = phone_number

      raise InvalidResourceError unless @resource.respond_to?(:verifications)
      raise InvalidPhoneNumberError unless Phonelib.valid?(@phone_number)
    end

    def call
      @resource.verifications.create!(phone_number: @phone_number)
    end
  end
end
