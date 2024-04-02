require 'rails_helper'

RSpec.describe 'EventsControllers', type: :request do
  let(:user) { User.new(email: 'default@users.com') }
  let(:default_headers) do
    {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Api-Key' => '',
      'Content-Type' => 'application/json',
      'User-Agent' => 'Ruby'
    }
  end

  let(:eu_api_host) { 'api.eu.iterable.com' }
  let(:us_api_host) { 'api.iterable.com' }

  let(:eu_headers) { default_headers.merge({ 'Host': eu_api_host }) }
  let(:us_headers) { default_headers.merge({ 'Host': us_api_host }) }

  before { sign_in user }

  def play_request(api_host, params, headers)
    stub_request(:post, "https://#{api_host}/api/events/track")
      .with(body: request_body, headers:)
      .to_return(status: 200, body: '{}', headers: {})

    post(action_path, params:)

    expect(a_request(:post, "https://#{api_host}/api/events/track")
      .with(body: request_body, headers:)).to have_been_made
  end

  describe 'POST /create_event_a' do
    let(:action_path) { events_create_event_a_path }
    let(:request_body) do
      {
        "email": 'default@users.com',
        "eventName": 'Event A'
      }
    end

    context 'when making requests to US API' do
      it 'should create event A successfully' do
        play_request(us_api_host, request_body, us_headers)
      end
    end

    context 'when making requests to EU API' do
      context 'when region is provided as a param' do
        it 'should create event A successfully' do
          play_request(eu_api_host, request_body.merge(region: 'eu'), eu_headers)
        end
      end

      context 'when region is an attribute of user' do
        it 'should create event A successfully' do
          user.region = :eu
          play_request(eu_api_host, request_body, eu_headers)
        end
      end
    end
  end

  describe 'POST /create_event_b' do
    let(:action_path) { events_create_event_b_path }
    let(:request_body) do
      {
        "email": 'default@users.com',
        "eventName": 'Event B'
      }
    end

    it 'should create event B successfully' do
      play_request(us_api_host, request_body, us_headers)
    end

    context 'when making requests to EU API' do
      context 'when region is provided as a param' do
        it 'should create event B successfully' do
          play_request(eu_api_host, request_body.merge(region: 'eu'), eu_headers)
        end
      end

      context 'when region is an attribute of user' do
        it 'should create event B successfully' do
          user.region = :eu
          play_request(eu_api_host, request_body, eu_headers)
        end
      end
    end
  end
end
