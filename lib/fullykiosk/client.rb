# frozen_string_literal: true

require "fullykiosk/connection"
require "fullykiosk/endpoint"

module FullyKiosk
  class Client
    include Connection
    include Endpoint

    API_BASE_URL = "https://cloud.fully-kiosk.com"

    def initialize(url: nil, email: nil, api_key: nil)
      @url = url || API_BASE_URL
      @email = email
      @api_key = api_key
    end
  end
end
