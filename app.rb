require 'sinatra'
require 'json'

class OrthodoxCalendar < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, 3000

  get '/' do
    content_type :json
    {
      status: "Orthodox Calendar API is working",
      hint: "Use /api/calendar?month=7&year=2025"
    }.to_json
  end

  get '/api/calendar' do
    content_type :json

    month = params['month']&.to_i
    year = params['year']&.to_i

    unless month && year && month.between?(1, 12) && year > 0
      halt 400, { error: "Invalid parameters. Use ?month=7&year=2025" }.to_json
    end

    days = (1..31).map do |day|
      break if !Date.valid_date?(year, month, day)

      {
        date: "%04d-%02d-%02d" % [year, month, day],
        feast: "Example feast",
        fasting: day % 6 == 0
      }
    end.compact

    {
      year: year,
      month: month,
      days: days
    }.to_json
  end
end
