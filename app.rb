require 'sinatra'
require 'json'
require 'rack/protection'

# Дозволити запити лише з дозволеного хоста (Render)
use Rack::Protection::HostAuthorization, hosts: ['orthocal-uk.onrender.com']

# Налаштування Sinatra
set :bind, '0.0.0.0'
set :port, 3000

# Головна сторінка (перевірка API)
get '/' do
  content_type :json
  {
    status: "Orthodox Calendar API is working",
    hint: "Use /api/calendar?month=7&year=2025"
  }.to_json
end

# Ендпоінт для календаря
get '/api/calendar' do
  content_type :json

  month = params['month']&.to_i
  year = params['year']&.to_i

  # Перевірка параметрів
  unless month && year && month.between?(1, 12) && year > 0
    halt 400, { error: 'Invalid parameters. Provide ?month=7&year=2025' }.to_json
  end

  # Тимчасово — повертаємо заглушку (можеш тут підключити справжні дані)
  {
    year: year,
    month: month,
    days: [
      { date: "#{year}-#{month}-01", feast: "Св. муч. Євдокії", fasting: false },
      { date: "#{year}-#{month}-02", feast: "Преп. Арсенія", fasting: true }
    ]
  }.to_json
end

