require 'sinatra'
require 'json'
require 'rack/protection'

# Обмеження доступу тільки з дозволених хостів (наприклад, Render)
use Rack::Protection::HostAuthorization, hosts: ['orthocal-uk.onrender.com']

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

  # Параметри запиту
  month = params['month']&.to_i || Time.now.month
  year  = params['year']&.to_i || Time.now.year

  # Тестові дані — тут у майбутньому можна підключити API, базу чи скрейпер
  calendar = [
    { date: "#{year}-#{month}-01", feast: "Св. муч. Юстина", type: "commemoration" },
    { date: "#{year}-#{month}-07", feast: "Різдво св. Івана Предтечі", type: "great feast" },
    { date: "#{year}-#{month}-12", feast: "Ап. Петра і Павла", type: "great feast" }
  ]

  {
    month: month,
    year: year,
    entries: calendar
  }.to_json
end
