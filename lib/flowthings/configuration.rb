module Flowthings
  module Configuration
    VALID_OPTIONS_KEYS    = [:account_name, :account_token].freeze
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :secure, :platform_version]
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT    = 'api.flowthings.io'
    DEFAULT_WS_ENDPOINT = 'ws.flowthings.io'
    DEFAULT_USER_AGENT  = "Flowthings API Ruby Gem #{Flowthings::VERSION}".freeze

    DEFAULT_ACCOUNT_TOKEN         = nil
    DEFAULT_ACCOUNT_NAME          = nil
    DEFAULT_SECURE                = true
    DEFAULT_PLATFORM_VERSION      = 'v0.1'

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self.secure = DEFAULT_SECURE
      self.platform_version = DEFAULT_PLATFORM_VERSION
      self.ws_endpoint = DEFAULT_WS_ENDPOINT

      self.account_token = DEFAULT_ACCOUNT_TOKEN
      self.account_name = DEFAULT_ACCOUNT_NAME
    end

    def configure
      yield self
    end

    def options
      Hash[* VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten]
    end
  end
end
