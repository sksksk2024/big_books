# Use the correct Ruby version
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y curl gnupg apt-transport-https

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs

# Install Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y yarn

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install bundler with the correct version
RUN gem install bundler:2.3.22

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . ./

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000 to the Docker host
EXPOSE 3000

# Specify the command to run your application
CMD ["rails", "server", "-b", "0.0.0.0"]