# frozen_string_literal: true

require "faraday"
require "faraday_middleware"

require "fullykiosk/fullykiosk_error"

module FullyKiosk
  module Connection
    def request(path, params)
      begin
        response = connection.get(path, params)
      rescue Faraday::ClientError, Faraday::ServerError => e
        raise FullyKiosk::APIConnectionError.faraday_error(e)
      end
      handle_response(response)
    end

    private

    def handle_response(response)
      case response.status
      when 200..299
        response.body
      else
        raise FullyKiosk::FullyKioskError.from_response(response.status, response.body, response.headers)
      end
    end

    def connection
      @connection ||= Faraday.new(url: @url) do |f|
        f.adapter Faraday.default_adapter
        f.request :url_encoded
        f.response :json, content_type: /\bjson$/
        f.use FaradayMiddleware::FollowRedirects
      end
    end
  end
end
