FROM ruby:3.1-alpine

WORKDIR /usr/src/app

COPY . .

RUN bundle install

CMD ["ruby", "./app.rb"]
