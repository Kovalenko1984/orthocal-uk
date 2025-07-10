FROM ruby:3.1
WORKDIR /app
COPY . /app
RUN bundle install
EXPOSE 3000
CMD ["ruby", "app.rb", "-o", "0.0.0.0"]
