require 'flowthings/platform_objects/platform_object_interface'
require 'flowthings/crud/find'

module Flowthings

  class Group < PlatformObjectInterface
    include Flowthings::Crud::Find
  end

end
