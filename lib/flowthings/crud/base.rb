require 'flowthings/utils/crud_utils'

module Flowthings
  module Crud
    module Base
      include Flowthings::CrudUtils

      def create(data, params={})
        path = mk_path
        params = mk_params params
        data = mk_data data

        platform_post path, data=data, params=params
      end

      def read(id=nil, params={})
        path = mk_path id: id
        params = mk_params params

        platform_get path, params=params
      end

      def update(id, data, params={})
        path = mk_path id: id
        params = mk_params params
        data = mk_data data

        platform_put path, data=data, params=params
      end

      def destroy(id, params={})
        path = mk_path id: id
        params = mk_params params

        platform_delete path, params=params
      end

      def read_all(params={})
        path = mk_path
        params = mk_params params

        platform_get path, params=params
      end

      alias_method :delete, :destroy
    end
  end
end
