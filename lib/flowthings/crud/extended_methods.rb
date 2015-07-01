module Flowthings
  module Crud
    module ExtendedMethods
      def delete_all(params={})
      end

      def find_many(filters={}, params={})
        path = mk_path
        params = mk_params(params)
        data = []

        @flowIds.each do flowId
          if filters[flowId]
            data << {"flowId" => flowId,
                     "params" => filters[flowId]}
          else
            data << {"flowId" => flowId}
          end
        end


        platform_mget(path, params=params, data=data)
      end
    end
  end
end
