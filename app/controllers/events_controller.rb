# frozen_string_literal: true

# Main controller for creating events using the Iterable API
# Talks directly to external APIs
# Does not save anything in the database
# Does not require authentication by default
class EventsController < ApplicationController
  def create_event_a
    ExternalApi::Iterable::Event.create_event('Event A', current_user&.email)
    flash[:alert] = 'Created event A'
    redirect_to root_url
  end

  def create_event_b
    ExternalApi::Iterable::Event.create_event('Event B', current_user&.email)
    flash[:alert] = 'Created event B'
    redirect_to root_url
  end
end
