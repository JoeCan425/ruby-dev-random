FROM ruby:2.6.3

LABEL MAINTAINER="Joe Canuel"

ENV APP_DIR /var/app/
WORKDIR $APP_DIR

# Add dependencies first to efficently use docker's cache
COPY Gemfile* $APP_DIR
RUN bundle install

# Copy over script
COPY main.rb $APP_DIR

CMD ["./main.rb"]