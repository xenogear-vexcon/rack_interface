require 'rack'
require_relative 'time_format'

class App

  def call(env)
    request = Rack::Request.new(env)
    get_request(request)
  end

  private

  def get_request(request)
    case request.path
    when  "/time"
      format_request(request)
    else
      unknown
    end
  end

  def format_request(request)
    time_formatter = TimeFormat.new(request.params['format'])
    
    if time_formatter.apply?
      response(status: 200, body: time_formatter.return_date)
    else
      response(status: 400, body: time_formatter.return_date)
    end
  end

  def unknown
    response(status: 404, body: 'Not Found')
  end

  def response(status:, headers: { 'Content-Type' => 'text/plain' }, body:)
    [status, headers, [body]]
  end

end