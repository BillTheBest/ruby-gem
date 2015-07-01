require 'net/http'
require 'uri'
require 'json'
require 'flowthings/response/raise_errors'

module Flowthings
  module Request

    include Flowthings::Response::RaiseErrors

    private

    def platform_get(path, params={}, options={})
      request(:get, path, params, options)
    end

    def platform_post(path, data, params={}, options={})
      request(:post, path, params, options, data=data)
    end

    def platform_put(path, data, params={}, options={})
      request(:put, path, params, options, data=data)
    end

    def platform_mget(path, data, params={}, options={})
      request(:mget, path, params, options, data=data)
    end

    def platform_delete(path, params={}, options={})
      request(:delete, path, params, options)
    end

    def request(method, path, params, options, data={})

      case method.to_sym
      when :get, :delete
        response = @connection.request(path: path,
                        query: params,
                        method: method.to_sym)
      when :post, :put, :mget
        body = params unless params.empty?
        body = JSON.generate(body)
        response = @connection.request(path: path,
                        query: params,
                        method: method.to_sym,
                        body: body)
      end

      raise_error(response)


      response = response.data

      response = JSON.parse response[:body]
      response = response["body"]
    end

  end
end
