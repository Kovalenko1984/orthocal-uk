require 'sinatra'
require 'json'

# Налаштування сервера (потрібно для Render)
set :bind, '0.0.0.0'
set :port, 3000

# Головна сторінка — тест
get '/' do
  content_type :json
  {
    status: "Orthodox Calendar API is working",
    hint: "Use /api/calendar?month=7&year=2025"
  }.to_json
end

# Основний API-ендпоінт
get '/api/calendar' do
  content_type :json

  # Параметри з URL
  month = params['month']&.to_i
  year = params['year']&.to_i

  # Перевірка параметрів
  unless month && year && month.between?(1, 12) && year > 0
    halt 400, { error: 'Invalid parameters. Use ?month=7&year=2025' }.to_json
  end

  # Простий список днів (поки що — тестові дані)
  days = (1..[31, 30, 29, 28].find { |d| Date.valid_date?(year, month, d) }).map do |day|
    {
      date: "#{year}-#{'%02d' % month}-#{'%02d' % day}",
      feast: "Свято №#{day}",
      fasting: day % 6 == 0
    }
  end

  {
    year: year,
    month: month,
    days: days
  }.to_json
end


