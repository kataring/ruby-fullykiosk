# frozen_string_literal: true

module FullyKiosk
  module Endpoint
    def list_devices
      send_command("/cloud", "listDevices")
    end

    private

    def send_command(path, cmd, **params)
      request(path, apiemail: @email, apikey: @api_key, cmd: cmd, **params)
    end
  end
end
