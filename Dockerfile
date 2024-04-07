# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-bullseye as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    RAILS_ENV="production" \
    RAILS_MASTER_KEY="a40b85e1f47a810af4fa17ee87dece6a" \
    PORT="4000" \
    REDIS_PORT="16679" \
    REDIS_URL="redis://host.docker.internal:16679" \
    MYSQL_HOST="gateway01.eu-central-1.prod.aws.tidbcloud.com" \
    MYSQL_PORT="4000" \
    MYSQL_USERNAME="3KZuxZRrtuTqZ1A.root" \
    MYSQL_PASSWORD="PJk55GragUKiQi0F"

# Update gems and bundler
RUN gem update --system --no-document && \
    gem install -N bundler


# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential default-libmysqlclient-dev

# Install application gems
COPY --link Gemfile Gemfile.lock ./
RUN bundle install && \
    bundle exec bootsnap precompile --gemfile && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy application code
COPY --link . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# ENV RAILS_MASTER_KEY=DUMMY

RUN SECRET_KEY_BASE=DUMMY ./bin/rails assets:precompile

# RUN if [[ "$RAILS_ENV" == "production" ]]; then \
#       mv config/credentials.yml.enc config/credentials.yml.enc.backup; \
#       mv config/credentials.yml.enc.sample config/credentials.yml.enc; \
#       mv config/master.key.sample config/master.key; \
#       bundle exec rails assets:precompile; \
#       mv config/credentials.yml.enc.backup config/credentials.yml.enc; \
#       rm config/master.key; \
#     fi

# Final stage for app image
FROM base

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl default-mysql-client && \
    apt-get install libjpeg62 && \
    apt-get install libpng-dev -y && \
    apt-get install libxrender1 -y && \
    apt-get install libfontconfig -y && \
    apt-get install libxext6 -y && \
    apt-get install -y libssl1.1 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R 1000:1000 db log storage tmp
USER 1000:1000

# USER root

# Deployment options
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true"

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 4000
CMD ["./bin/rails", "server"]
