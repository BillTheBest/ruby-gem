require 'json'

module Flowthings
  module Response
    module RaiseErrors

      private
      def raise_error(response)

        begin
          body = JSON.parse response[:body]
        rescue JSON::ParserError => e
          body = response[:body]
        end

        status = response[:status].to_i

        head = body["head"]
        errors = head["errors"]


        case status
        when 400
          raise Flowthings::Error::BadRequest.new errors, head
        when 403
          raise Flowthings::Error::NotFound.new errors, head
        when 404
          raise Flowthings::Error::NotFound.new errors, head
        when 413
          raise Flowthings::Error::Forbidden.new errors, head
        when 500
          raise Flowthings::Error::ServerError.new errors, head
        when 503
          raise Flowthings::Error::ServiceUnavailable.new "503 no service is available to handle this request", head
        end

      end


    end
  end
end
