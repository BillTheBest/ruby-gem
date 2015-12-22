####################################
# GM: This is just an example for how to set up a simple websocket client.
# It's only here for my personal notes.
####################################

require 'excon'
require 'pp'
require 'json'
require 'eventmachine'
require 'faye/websocket'

require 'dotenv'
Dotenv.load

account_name = ENV["FT_ACCOUNT_NAME"]
account_token = ENV["FT_ACCOUNT_TOKEN"]

flow_id = ENV["FLOW_ID"]

url = 'https://ws.flowthings.io/'

connection = Excon.new(url,
                       headers: {
                         'X-Auth-Token' => account_token,
                         'X-Auth-Account' => account_name,
                         'Content-Type' => 'application/json',
                       })

resp = connection.request(path: '/session',
                          method: :post,
                          body: JSON.generate({}))

session_id = JSON.parse(resp.body)["body"]["id"]

ws_url = "wss://ws.flowthings.io/session/#{session_id}/ws"

sub_msg = {
  msgId: "my-subscribe",
  object: "drop",
  type: "subscribe",
  flowId: flow_id
}

drop = {
  msgId: "dropcreate",
  object: "drop",
  type: "create",
  flowId: flow_id,
  value:{
    elems: {
      asdfasdf: "asdfasdf"
    }
  }
}


EM.run {
  ws = Faye::WebSocket::Client.new(ws_url)

  loop = EM.add_periodic_timer(1) {
    ws.ping 'ping'
  }

  ws.on :message do |event|
    data = JSON.parse(event.data)
    pp [:message, data]

    if data && data["head"] && data["head"]["msgId"] == "my-subscribe"
      ws.send(JSON.generate(drop))
    end
  end

  ws.on :open do |event|
    pp [:open, "opened"]
    ws.send(JSON.generate(sub_msg))
  end

  ws.on :close do |event|
    EM.cancel_timer(loop)
    pp [:close, "closed"]
    ws = nil
  end

  ws.on :error do |event|
    pp [:close, "error"]
    ws = nil
  end
}
