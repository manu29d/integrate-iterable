# frozen_string_literal: true

module ExternalApi
  # This module is supposed to handle HTTP request
  # Though not much is going on as of now since
  # we don't know the complete spec
  # Hence, for now, this is just a simple wrapper around Net::HTTP
  module HandleRequests
    DEFAULT_HEADERS = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      use_ssl: true
    }.freeze

    # The following 2 methods look very similar
    # But in a real wold application,
    # there would be different error handling
    # and even customized error response for POST requests
    def get(url = '', headers = {})
      uri = URI(url)
      res = Net::HTTP.get_response(uri, DEFAULT_HEADERS.merge(headers))
      body = res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : nil
      body || res
    end

    def post(url, payload, headers = {})
      uri = URI(url)
      res = Net::HTTP.post_response(uri, payload, DEFAULT_HEADERS.merge(headers))
      body = res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : nil
      body || res
    end
  end
end
