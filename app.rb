require 'sinatra'
require 'json'
require 'rack/protection'

# Дозволяємо Render-домен
use Rack::Protection::HostAuthorization, hosts: [
  'orthocal-uk.onrender.com',
  /\.onrender\.com$/
]

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

  month = params['month']&.to_i || Time.now.month
  year = params['year']&.to_i || Time.now.year

  {
    year: year,
    month: month,
    days: (1..31).map { |d| { day: d, feast: "Свято №#{d}" } }
  }.to_json
end
