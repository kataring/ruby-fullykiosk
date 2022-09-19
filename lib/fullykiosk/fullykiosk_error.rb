# frozen_string_literal: true

module FullyKiosk
  class FullyKioskError < StandardError
    def self.from_response(response)
      klass =
        case response.status
        when 400 then BadRequest
        when 401 then Unauthorized
        when 403 then Forbidden
        when 404 then NotFound
        when 500..599 then ServerError
        else ServerError
        end

      klass&.new(response.body)
    end

    attr_reader :status, :error_response

    def initialize(message, status = nil, error_response = nil)
      @status = status
      @error_response = error_response
      super(message)
    end
  end

  class BadRequest < StandardError; end

  class Unauthorized < StandardError; end

  class Forbidden < StandardError; end

  class NotFound < StandardError; end

  class ServerError < StandardError; end

  class APIConnectionError < StandardError
    def self.faraday_error(err)
      new("Connection with FullyKiosk API failed. #{err.message}", err)
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
