# frozen_string_literal: true

module ExternalApi
  # The idea here is that Iterable is one ExternalApi
  # But in the future there will be many
  # We can keep adding their own modules
  module Iterable
    # Assuming an API_KEY exists with the users of this application
    # If not, the following requests are supposed to fail
    API_KEY = ENV.fetch('ITERABLE_API_KEY', '')
    EU_API_KEY = ENV.fetch('ITERABLE_EU_API_KEY', '')
    BASE_URL = 'https://api.iterable.com/api'
    EU_BASE_URL = 'https://api.eu.iterable.com/api'

    # Helper to separate EU/US API Keys and Base urls
    module IterableHelper
      def get_api_key(region = 'us')
        # return US API_KEY if region is not provided
        region&.downcase == 'eu' ? EU_API_KEY : API_KEY
      end

      def get_base_url(region = 'us')
        # return US API url if region is not provided
        region&.downcase == 'eu' ? EU_BASE_URL : BASE_URL
      end

      def get_headers(region)
        { 'Api-Key': get_api_key(region) }
      end
    end

    # A separate class has been added for each of the APIs we're using
    # Since each sub-heading in the Swagger docs includes multiple
    # sub-paths that have their own way of handling responses/requests
    # This class is supposed to handle tracking events for Iterable API
    class Event
      include IterableHelper
      include HandleRequests
      API_URL = '/events'

      def create_event(event_type, region, user = nil)
        # Instead of throwing a proper error,
        # we're doing the lazy thing of returning nil early
        return unless event_type

        region ||= user&.region

        url = "#{get_base_url(region)}#{API_URL}/track"
        payload = { email: user&.email, eventName: event_type }
        post(url, payload, get_headers(region))
      end
    end

    # In a real-world scenario, each of these classes
    # shall be in it's own files
    # This class is supposed handle adding users to the Iterable API
    class User
      include IterableHelper
      include HandleRequests
      API_URL = '/users'

      def get_user(email = nil, region = 'us')
        # Instead of throwing a proper error,
        # we're doing the lazy thing of returning nil early
        return unless email

        url = "#{get_base_url(region)}#{API_URL}/#{email}"
        get(url, get_headers(region))
      end

      def create_user(user_email, region = 'us')
        url = "#{get_base_url(region)}#{get_api_key(region)}/update"
        payload = { email: user_email }
        post(url, payload, get_headers(region))
      end
    end
  end
end
