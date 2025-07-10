FROM ruby:3.2

WORKDIR /app

COPY . .

RUN bundle install

EXPOSE 3000

CMD ["rackup", "--host", "0.0.0.0", "--port", "3000"]
