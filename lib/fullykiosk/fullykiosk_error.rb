# frozen_string_literal: true

module FullyKiosk
  class FullyKioskError < StandardError
    RESPONSE_STATUS = "status"
    RESPONSE_STATUSTEXT = "statustext"
    RESPONSE_ERRORSTATUS = "Error"

    def self.from_response(status, body, headers)
      body ||= {}

      raise new(RESPONSE_ERRORSTATUS, body[RESPONSE_STATUSTEXT]) if body[RESPONSE_STATUS] == RESPONSE_ERRORSTATUS
    end
  end

  class APIConnectionError < FullyKioskError
    def self.faraday_error(e)
      new("Connection with FullyKiosk API server failed. #{e.message}", e)
    end

    attr_reader :original_error

    def initialize(message, original_error = nil)
      @original_error = original_error

      if original_error && original_error.response.is_a?(Hash)
        super(message, original_error.response[:status], original_error.response[:body])
      else
        super(message)
      end
    end
  end

end

