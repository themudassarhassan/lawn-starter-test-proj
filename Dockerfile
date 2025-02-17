ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS development

# Rails app lives here
WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl libvips sqlite3 build-essential git pkg-config libsqlite3-dev && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    PATH="/rails/bin:${PATH}"

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install
# Copy application code
COPY . .

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
# Run development server
CMD ["rails", "server", "-b", "0.0.0.0"]
