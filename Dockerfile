FROM ruby:3.1

WORKDIR /app
COPY . /app

RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "3000"]
