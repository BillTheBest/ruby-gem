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

      @on = {}
    end

    def on(event, &blk)
      @on[event] = blk
    end

    def send(data)

    end

    def run(&blk)
      ws = Faye::WebSocket::Client.new(ws_url)

      blk.call()
    end

    def drop
    end

    def track
    end

    def flow
    end

  end
end
