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

    attr_accessor :flow_id, :flow_ids

    def initialize(flow_id, connection, options={})
      if flow_id.kind_of? Array
        @flow_ids = flow_id
      else
        @flow_id = flow_id
      end

      super connection, options
    end

    def create(data, params={})
      if !data["path"] && !@flow_id
        raise ArgumentError.new("You either need a path in the drop data, or the Drop instance needs a flow_id")
      end

      super data, params
    end

  end

end
