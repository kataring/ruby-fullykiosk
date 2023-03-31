# frozen_string_literal: true

module FullyKiosk
  module Endpoint
    PATH_CLOUD = "/cloud"
    PATH_REMOTE = "/remote"

    # Deviceの情報を取得する
    def device(devid, filter = nil)
      params = {}
      params[:devid] = devid
      params[:filter] = filter unless filter.nil?
      send_command(PATH_CLOUD, "listDevices", params)
    end

    # Groupに属するデバイスを取得する
    def devices(groupid, filter = nil)
      params = {}
      params[:groupid] = groupid
      params[:filter] = filter unless filter.nil?
      send_command(PATH_CLOUD, "listDevices", params)
    end

    # Deviceの設定を取得する
    def status(devid)
      params = {}
      params[:devid] = devid
      send_command(PATH_REMOTE, "getDeviceInfo", params)
    end

    # Deviceを再起動する
    def reboot(devid)
      params = {}
      params[:devid] = devid
      params[:nowait] = 1
      params[:persistent] = 1
      send_command(PATH_REMOTE, "rebootDevice", params)
    end

    private

    def send_command(path, cmd, params)
      request(path, cmd: cmd, **params)
    end
  end
end
