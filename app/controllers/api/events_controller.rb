class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :set_access_control_headers

  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
    
    if !registered_application
      render json: "Unregistered application", status: :unprocessable_entity
    else
      @event = registered_application.events.build(event_params)

      if @event.save
        render json: @event, status: :created
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

private
  def event_params
    params.permit(:name)
  end

  # CORS
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Origin, Content-Type'
  end

  # CORS preflight sanity checks client/server to allow legacy servers to support CORS
  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Origin, X-Requested-With, X-Prototype-Version, Content-Type'
    headers['Access-Control-Max-Age'] = '1728000'
    render text: "" if request.method == "OPTIONS"
  end
  # curl -v -H "Accept: application/json" -H "Origin: http://localhost:3000" --header "Content-type: application/json" -X POST -d '{"name":"foo"}'  http://localhost:9000/api/events
end
