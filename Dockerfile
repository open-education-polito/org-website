# Use the official Ruby image as a parent image
FROM ruby:2.7

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs git

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler -v 2.3.26
RUN bundle install

# Copy the rest of the application code
COPY . .

# Build the Jekyll site
RUN bundle exec jekyll build --config _prod.yml

# Expose the port the app runs on
EXPOSE 4000

# Define the command to run the app
CMD ["jekyll", "serve", "--config", "_prod.yml"]