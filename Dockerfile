FROM ruby:3.1
ARG RUBYGEMS_VERSION=3.3.20

# RUN apt-get update && apt-get install -y nodejs

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client


RUN mkdir /app
WORKDIR /app

# Node.jsパッケージのインストール
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install


COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
