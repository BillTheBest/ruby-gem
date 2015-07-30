require 'faye/websocket'
require 'eventmachine'
require 'flowthings/request'
require 'flowthings/error'

module Flowthings
  class WebSocket
    include Flowthings::Request

    def initialize
      @session_id = platform_post("/session")["id"]
      @ws_url = "wss://ws.flowthings.io/session/#{session_id}/ws"

      @on = {
        open: [],
        message: [],
        close: []
      }
    end

    def on(event)
      # I'm not sure what the best way to do this is.
    end

    def run

    end

  end
end
