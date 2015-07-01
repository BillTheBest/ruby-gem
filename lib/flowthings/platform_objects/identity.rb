require 'flowthings/platform_objects/platform_object_interface'
require 'flowthings/crud/find'

module Flowthings

  class Identity < PlatformObjectInterface
    include Flowthings::Crud::Find
  end

end
