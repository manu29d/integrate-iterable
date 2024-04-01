# frozen_string_literal: true

module ExternalApi
  # The idea here is that Iterable is one ExternalApi
  # But in the future there will be many
  # We can keep adding their own modules
  module Iterable
    # Assuming an API_KEY exists with the users of this application
    # If not, the following requests are supposed to fail
    API_KEY = ENV.fetch('ITERABLE_API_KEY') || ''
    BASE_URL = 'https://api.iterable.com/api'

    # A separate class has been added for each of the APIs we're using
    # Since each sub-heading in the Swagger docs includes multiple
    # sub-paths that have their own way of handling responses/requests
    # This class is supposed to handle tracking events for Iterable API
    class Event
      include HandleRequests
      API_URL = '/events'

      def create_event(event_type, user_email = '')
        # Instead of throwing a proper error,
        # we're doing the lazy thing of returning nil early
        return unless event_type

        url = "#{BASE_URL}#{API_URL}/track"
        payload = { email: user_email, eventName: event_type }
        post(url, payload)
      end
    end

    # In a real-world scenario, each of these classes
    # shall be in it's own files
    # This class is supposed handle adding users to the Iterable API
    class User
      include HandleRequests
      API_URL = '/users'

      def get_user(email = nil)
        # Instead of throwing a proper error,
        # we're doing the lazy thing of returning nil early
        return unless email

        url = "#{BASE_URL}#{API_URL}/#{email}"
        get(url)
      end

      def create_user(user_email)
        url = "#{BASE_URL}#{API_URL}/update"
        payload = { email: user_email }
        post(url, payload)
      end
    end
  end
end
