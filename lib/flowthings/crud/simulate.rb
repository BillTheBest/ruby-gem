module Flowthings
  module Crud
    module Simulate
      def simulate(data, params={})
        path = mk_path({tail: "simulate"})
        params = mk_params(params)
        data = mk_data(data)

        platform_post(path, params=params, data=data)
      end
    end
  end
end
