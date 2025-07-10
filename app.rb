require 'sinatra'
require 'json'
require 'rack/protection'

# Дозволити лише домени Render і локальні (уникаємо помилок 403)
use Rack::Protection::HostAuthorization, hosts: lambda { |host| 
  host.end_with?('.onrender.com') || host == 'localhost' 
}

# Параметри запуску
set :bind, '0.0.0.0'
set :port, 3000

# Тестовий ендпоінт
get '/' do
  content_type :json
  {
    status: "Orthodox Calendar API is working",
    hint: "Use /api/calendar?month=7&year=2025"
  }.to_json
end

# Основний API
get '/api/calendar' do
  content_type :json

  # Отримати параметри
  month = params['month']&.to_i || Time.now.month
  year = params['year']&.to_i || Time.now.year

  # Тимчасово: згенерувати простий календар
  {
    year: year,
    month: month,
    days: (1..31).map { |d| { day: d, feast: "Свято №#{d}" } }
  }.to_json
end

