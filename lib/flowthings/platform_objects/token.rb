require 'flowthings/platform_objects/platform_object_interface'

module Flowthings

  class Token < PlatformObjectInterface
    undef_method :update
  end

end
