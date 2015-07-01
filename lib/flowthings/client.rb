require 'active_support/inflector'
require 'flowthings/platform_objects/api_task'
require 'flowthings/platform_objects/drop'
require 'flowthings/platform_objects/flow'
require 'flowthings/platform_objects/group'
require 'flowthings/platform_objects/identity'
require 'flowthings/platform_objects/mqtt'
require 'flowthings/platform_objects/share'
require 'flowthings/platform_objects/token'
require 'flowthings/platform_objects/track'

module Flowthings
  class Client
    attr_accessor *Configuration::VALID_CONFIG_KEYS
    include Flowthings::Connection

    def initialize(options={})
      @services = [ApiTask, Drop, Flow, Group, Identity, Mqtt, Share, Token, Track]
      merged_options = Flowthings.options.merge(options)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end

      service_factory
    end

    private
    def get_options
      opts = {}
      Configuration::VALID_CONFIG_KEYS.each do |key|
        opts[key.to_sym] = send("#{key}")
      end

      opts
    end

    def service_factory
      @services.each do |service|
        # service.name.underscore looks like this: flowthings/api_importer
        # so, I have to split it like that.
        service_name = service.name.underscore.split("/")[1]

        if service_name == "drop"
          instance_eval(<<-EOS)
            def #{service_name}(flowId)
              #{service}.new flowId, connection, get_options
            end
          EOS
        else
          instance_eval(<<-EOS)
            def #{service_name}
              #{service}.new connection, get_options
            end
          EOS
        end

      end

    end

  end
end
