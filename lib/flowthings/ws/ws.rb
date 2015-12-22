require 'faye/websocket'
require 'eventmachine'
require 'flowthings/request'
require 'flowthings/error'

module Flowthings
  class WebSocket
    include Flowthings::Request

    def initialize
      session_id = platform_post("/session", {}, {}, {ws: true})["id"]
      @ws_url = "wss://ws.flowthings.io/session/#{session_id}/ws"

      @on = {
        drop: [],
        track: [],
        flow: []
      }
    end

    def on(event, &blk)
      if @on.key? event
        @on[event].push(blk)
      else
        @on[event] = [blk]
      end
    end

    def send(data)

    end

    def run(&blk)
      ws = Faye::WebSocket::Client.new(ws_url)

      blk.call()
    end

    def drop(flow_id)
    end

    def track
    end

    def flow
    end

  end
end
