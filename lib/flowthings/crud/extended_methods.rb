require 'flowthings/utils/crud_utils'

module Flowthings
  module Crud
    module ExtendedMethods
      include Flowthings::CrudUtils

      def destroy_all(params={})
        path = mk_path
        params = mk_params params

        platform_delete path, params=params
      end

      def find_many(filters={}, params={})
        path = mk_path
        params = mk_params params
        data = []

        @flow_ids.each do flow_id
          if filters[flow_id]
            data << {"flowId" => flow_id,
                     "params" => filters[flow_id]}
          else
            data << {"flowId" => flow_id}
          end
        end


        platform_mget path, data=data, params=params
      end

      alias_method :delete_all, :destroy_all
    end
  end
end
