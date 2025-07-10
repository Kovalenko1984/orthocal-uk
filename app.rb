require 'sinatra'
require 'json'
require 'rack/protection'

# Дозволити запити лише з піддоменів *.onrender.com
use Rack::Protection::HostAuthorization, hosts: lambda { |host| host.end_with?('.onrender.com') || host == 'localhost' }

# Налаштування Sinatra
set :bind, '0.0.0.0'
set :port, 3000

# Головна сторінка
get '/' do
  content_type :json
  {
    status: 'Orthodox Calendar API is working',
    hint: 'Use /api/calendar?month=7&year=2025'
  }.to_json
end

# API для календаря
get '/api/calendar' do
  content_type :json

  # Отримання параметрів місяця і року з запиту
  month = params['month']&.to_i
  year = params['year']&.to_i

  if month.nil? || month < 1 || month > 12 || year.nil? || year < 1900
    status 400
    return { error: 'Invalid or missing parameters: month and year are required (e.g. ?month=7&year=2025)' }.to_json
  end

  # Заглушка — тут має бути твоя логіка генерації календаря
  days = (1..31).map do |day|
    {
      date: "#{year}-#{'%02d' % month}-#{'%02d' % day}",
      saint: "Example Saint for #{day}.#{month}.#{year}",
      readings: "Example Reading for #{day}.#{month}.#{year}"
    }
  end

  { month: month, year: year, days: days }.to_json
end

