require 'flowthings/request'
require 'flowthings/connection'
require 'flowthings/crud/base'
require 'flowthings/error'

module Flowthings

  class PlatformObjectInterface

    include Flowthings::Request
    include Flowthings::Crud::Base

    @path_array = []

    # make a class variable here, a hash,
    # that holds all the various endpoints in it

    # then make a call here to query the object type
    # and give it the right endpoint function type.

    def initialize(connection, options={})
      check_platform_object

      Configuration::VALID_CONFIG_KEYS.each do |key|
        instance_variable_set("@#{key}", options[key])
      end

      @connection = connection

      @account_name=options[:account_name]
      @account_token=options[:account_token]
    end


    private
    def check_platform_object
      if self.class == PlatformObjectInterface
        raise Flowthings::Error::ObjectError, "Use the actual platform objects"
      end
    end

  end

end
