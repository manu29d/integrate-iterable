# frozen_string_literal: true

# Main controller for creating events using the Iterable API
# Talks directly to external APIs
# Does not save anything in the database
# Does not require authentication by default
# Let's assume we can send region along with the request params
# If not, the user may have a region attributed to it in the db
class EventsController < ApplicationController
  def create_event_a
    ExternalApi::Iterable::Event.new.create_event('Event A', params[:region] || nil, current_user)
    flash[:alert] = 'Created event A'
    redirect_to root_url
  end

  def create_event_b
    ExternalApi::Iterable::Event.new.create_event('Event B', params[:region] || nil, current_user)
    ExternalApi::Iterable::Email.new.send_email(params[:region], current_user)
    flash[:alert] = 'Created event B'
    redirect_to root_url
  end
end
