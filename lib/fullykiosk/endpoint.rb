# frozen_string_literal: true

module FullyKiosk
  module Endpoint
    PATH_CLOUD = "/cloud"
    PATH_REMOTE = "/remote"

    def list_devices
      send_command(PATH_CLOUD, "listDevices")
    end

    def get_device_info(devid)
      send_command(PATH_REMOTE, "getDeviceInfo", type: "json", devid: devid)
    end

    private

    def send_command(path, cmd, **params)
      request(path, apiemail: @email, apikey: @api_key, cmd: cmd, **params)
    end
  end
end
