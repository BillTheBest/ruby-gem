require 'flowthings/platform_objects/platform_object_interface'
require 'flowthings/crud/extended_methods'
require 'flowthings/crud/find'
require 'flowthings/crud/member_update'
require 'flowthings/crud/aggregate'

module Flowthings

  class Drop < PlatformObjectInterface
    include Flowthings::Crud::ExtendedMethods
    include Flowthings::Crud::Find
    include Flowthings::Crud::MemberUpdate
    include Flowthings::Crud::Aggregate

    attr_accessor :flowId

    def initialize(flowId, connection, options={})
      if flowId.kind_of? Array
        @flowIds = flowId
      else
        @flowId = flowId
      end

      super connection, options
    end

  end

end
