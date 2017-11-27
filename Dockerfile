FROM ruby:2.4-alpine3.6
MAINTAINER Christopher Hein <me@christopherhein.com>

ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

COPY . $APP_HOME

CMD ["ruby", "app.rb"]
