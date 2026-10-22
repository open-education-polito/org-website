# Same Ruby version as CI, pinned by digest (Dependabot's docker ecosystem can bump it)
FROM ruby:3.4@sha256:f368a521417846ed4d0b0582e8a3f0fa8e579c58e364f9dacfda70b7168f1dd7

# Build tools for native gems only; clean up to reduce image size
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Unprivileged user to run the dev server
RUN useradd --create-home --uid 1000 app

# Set the working directory in the container
WORKDIR /usr/src/app
RUN chown app:app /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY --chown=app:app Gemfile Gemfile.lock ./

# Install Bundler (version from Gemfile.lock) and gems
RUN gem install bundler -v 4.0.21
RUN bundle install --jobs 4 --retry 5

# Gems are installed as root; the app runs unprivileged
USER app

# Copy the rest of the application code
COPY --chown=app:app . .

# Expose the port the app runs on
EXPOSE 4000

# Define the command to run the app
CMD ["bundle", "exec", "jekyll", "serve", "--config", "_prod.yml", "--host", "0.0.0.0", "--port", "4000"]
