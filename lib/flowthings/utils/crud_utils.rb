module Flowthings
  module CrudUtils
    private
    def mk_data(data, params = {})
      data
    end

    def mk_path(params = {})
      service_path = {
        "Flowthings::Drop" => "drop",
        "Flowthings::Flow" => "flow",
        "Flowthings::Track" => "track",
        "Flowthings::Identity" => "identity",
        "Flowthings::Token" => "token",
        "Flowthings::Share" => "share",
        "Flowthings::Group" => "group",
        "Flowthings::ApiTask" => "api-task",
        "Flowthings::Mqtt" => "mqtt"
      }

      path = [@platform_version, @account_name, service_path[self.class.name]]

      if @flowId
        path << @flowId
      end

      if params[:id]
        path << params[:id]
      end

      # a tail is somethings we put after the id on the flow.
      # "/aggregate" would be an example
      if params[:tail]
        path << params[:tail]
      end

      path = "/" + path.join('/')
    end

    def mk_regex()

    end

    def mk_params(params = {})

      made_params = {}

      if params[:start]
        made_params[:start] = params[:start]
      end

      if params[:limit]
        made_params[:limit] = params[:limit]
      end

      if params[:sort]
        made_params[:sort] = params[:sort]
      end

      if params[:order]
        made_params[:order] = params[:order]
      end

      if params[:only]
        made_params[:only] = params[:only]
      end

      if params[:refs]
        made_params[:refs] = 1
      end

      if params[:hints] == false
        made_params[:hints] = false
      end

      if params[:filter]
        #we'll make this more dynamic later
        made_params[:filter] = params[:filter]
      end

      made_params
    end

    def mk_filter(params = {})
      # this is just a string for now
      filter = []

      params.each do |key, value|

      end

      filter
    end

  end
end
