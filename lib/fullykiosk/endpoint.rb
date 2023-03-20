# frozen_string_literal: true

module FullyKiosk
  module Endpoint
    PATH_CLOUD = "/cloud"
    PATH_REMOTE = "/remote"

    def list_devices(filter: '', groupid: '')
      params = {}
      params[:filter] = filter unless filter.empty?
      params[:groupid] = groupid unless groupid.empty?
      send_command(PATH_CLOUD, "listDevices", params)
    end

    def get_device_info(devid)
      send_command(PATH_REMOTE, "getDeviceInfo", devid: devid)
    end

    def reboot_device(devid)
      send_command(PATH_REMOTE, "rebootDevice", devid: devid, nowait: 1, persistent: 1)
    end

    private

    def send_command(path, cmd, **params)
      request(path, apiemail: @email, apikey: @api_key, type: "json", cmd: cmd, **params)
    end
  end
end
