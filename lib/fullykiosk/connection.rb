# frozen_string_literal: true

require "faraday"
require "faraday_middleware"

require "fullykiosk/fullykiosk_error"

module FullyKiosk
  module Connection
    RESPONSE_STATUS = "status"
    RESPONSE_STATUSTEXT = "statustext"
    RESPONSE_ERROR_STATUS = "Error"

    def request(path, params)
      begin
        params[:apiemail] = @email
        params[:apikey] = @api_key
        params[:type] = "json"
        response = connection.get(path, params)
      rescue Faraday::ClientError, Faraday::ServerError, Faraday::ConnectionFailed => e
        raise FullyKiosk::APIConnectionError.faraday_error(e)
      end

      handle_response(response)
    end

    private

    def handle_response(response)
      response_body = response.body

      if response.success?
        raise FullyKioskError.from_response(response) unless response_body

        if response_body[RESPONSE_STATUS] == RESPONSE_ERROR_STATUS
          raise FullyKioskError.new(response_body[RESPONSE_STATUSTEXT], response.status, response_body)
        end

        return response_body
      end

      raise FullyKioskError.from_response(response)
    end

    def connection
      @connection ||= Faraday.new(url: @url) do |f|
        f.adapter Faraday.default_adapter
        f.request :url_encoded
        f.response :json
        f.use FaradayMiddleware::FollowRedirects
      end
    end
  end
end
