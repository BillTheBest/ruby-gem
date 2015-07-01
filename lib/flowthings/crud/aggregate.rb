require 'flowthings/utils/crud_utils'

module Flowthings
  module Crud
    module Aggregate
      include Flowthings::CrudUtils

      def aggregate(data, params={})
        path = mk_path({tail: "aggregate"})
        params = mk_params(params)
        data = mk_data(data)

        platform_post(path, params=params, data=data)
      end

    end
  end
end
