require 'flowthings/utils/crud_utils'

module Flowthings
  module Crud
    module MemberUpdate
      include Flowthings::CrudUtils

      def member_update(id, member_name, data, params={})
        path = mk_path tail: member_name, id: id
        params = mk_params params
        data = mk_data data

        platform_put path, params=params, data=data
      end
    end
  end
end
