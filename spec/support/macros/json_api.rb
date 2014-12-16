module Macros
  module JsonApi
    def json_reply
      HashWithIndifferentAccess.new(JSON.parse(response.body))
    end

    def api_response
      puts json_reply
      json_reply[:response]
    end
  end
end
