# Use a specific Ruby version for consistency
FROM ruby:3.1

# Install dependencies and clean up to reduce image size
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY Gemfile ./

# Install Bundler and gems
RUN gem install bundler
RUN bundle install --jobs 4 --retry 5

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 4000

# Define the command to run the app
CMD ["jekyll", "serve", "--config", "_prod.yml", "--host", "0.0.0.0", "--port", "4000"]
