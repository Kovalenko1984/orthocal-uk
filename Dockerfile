FROM ruby:3.2

WORKDIR /app
COPY . .

RUN gem install bundler && bundle install

EXPOSE 3000

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "3000"]
