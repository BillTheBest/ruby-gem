require 'flowthings/platform_objects/platform_object_interface'

module Flowthings

  class Share < PlatformObjectInterface
    undef_method :update
  end

end
