require 'flowthings/platform_objects/platform_object_interface'
require 'flowthings/crud/find'
require 'flowthings/crud/member_update'

module Flowthings

  class Flow < PlatformObjectInterface
    include Flowthings::Crud::Find
    include Flowthings::Crud::MemberUpdate
  end

end
