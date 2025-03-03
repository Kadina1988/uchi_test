FROM ruby:3.1

WORKDIR /app 

COPY Gemfile Gemfile.lock ./

COPY . /app

RUN bundle install 