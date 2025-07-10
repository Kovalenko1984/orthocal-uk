require 'sinatra'
require 'json'
require 'date'

set :port, 3000
set :bind, '0.0.0.0'

get '/api/v1/calendar' do
  content_type :json
  date = params['date'] || Date.today.to_s
  locale = params['locale'] || 'uk'

  {
    date: date,
    fast: "немає посту",
    saints: ["Священномученик Панкра́тій, єпископ Таормінський"],
    readings: [
      { title: "Апостол: Рим. 11:2-12" },
      { title: "Євангеліє: Мт. 11:20-26" }
    ]
  }.to_json
end