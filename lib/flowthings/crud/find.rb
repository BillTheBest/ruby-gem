require 'flowthings/utils/crud_utils'

module Flowthings
  module Crud
    module Find
      include Flowthings::CrudUtils

      def find(params={})
        path_params = {}
        path = mk_path(path_params)
        params = mk_params(params)

        platform_get(path, params=params)
      end
    end
  end
end
