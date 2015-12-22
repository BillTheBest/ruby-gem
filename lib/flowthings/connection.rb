require 'excon'
require 'active_support/notifications'
require 'flowthings/error'

module Flowthings
  module Connection
    private

    def connection
      url = @endpoint
      if @secure
        url = 'https://' + url
      else
        url = 'http://' + url
      end

      @connection = Excon.new(url,
                              headers: {
                                'X-Auth-Token' => @account_token,
                                'Content-Type' => 'application/json',
                                'User-Agent' => @user_agent
                              })
    end

    def ws_connection
      url = 'https://' + @ws_endpoint

      @ws_connection = Excon.new(url,
                              headers: {
                                'X-Auth-Token' => @account_token,
                                'X-Auth-Account' => @account_name,
                                'Content-Type' => 'application/json',
                                'User-Agent' => @user_agent
                              })
    end
  end
end
