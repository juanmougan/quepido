FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_ROOT /var/www/que-pido
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
ADD Gemfile* $APP_ROOT/
RUN bundle install
ADD . $APP_ROOT

EXPOSE 4567
CMD ["ruby", "quepido.rb"]
