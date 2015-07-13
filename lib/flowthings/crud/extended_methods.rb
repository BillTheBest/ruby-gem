require 'flowthings/utils/crud_utils'

module Flowthings
  module Crud
    module ExtendedMethods
      include Flowthings::CrudUtils
      def delete_all(params={})
      end

      def find_many(filters={}, params={})
        path = mk_path
        params = mk_params params
        data = []

        @flowIds.each do flowId
          if filters[flowId]
            data << {"flowId" => flowId,
                     "params" => filters[flowId]}
          else
            data << {"flowId" => flowId}
          end
        end


        platform_mget path, data=data, params=params
      end
    end
  end
end
