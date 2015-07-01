module Flowthings
  class PlatformResponse
    attr_reader :head, :body, :full_message, :errors, :status, :response_headers, :excon_object

    def initialize(response)
      @excon_object = response
      @status = response.status
      @response_headers = response.headers
      @full_message = response.body
      @head = @full_message["head"]
      @body = @full_message["body"]
      @errors = @head["errors"]
    end

  end
end
