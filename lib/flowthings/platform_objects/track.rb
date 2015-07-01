require 'flowthings/platform_objects/platform_object_interface'
require 'flowthings/crud/find'
require 'flowthings/crud/simulate'

module Flowthings

  class Track < PlatformObjectInterface
    include Flowthings::Crud::Find
    include Flowthings::Crud::Simulate
  end

end
