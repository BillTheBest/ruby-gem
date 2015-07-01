module Flowthings
  class Error < StandardError
    def initialize(message="")
      if message
        super(message)
      end
    end
  end

  class Error::HttpError < Flowthings::Error
    attr_reader :http_headers

    def initialize(message, http_headers="")
      @http_headers = http_headers
      super(message)
    end
  end

  class Error::ObjectError         < Flowthings::Error; end

  class Error::ServerError        < Error::HttpError; end
  class Error::ServiceUnavailable < Error::ServerError; end

  class Error::ClientError        < Error::HttpError; end
  class Error::Forbidden          < Error::ClientError; end
  class Error::NotFound           < Error::ClientError; end
  class Error::BadRequest         < Error::ClientError; end
  class Error::RequestTooLarge    < Error::ClientError; end

end
