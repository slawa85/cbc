source 'https://rubygems.org'

gem 'rails', '4.2.10'

gem 'rails-api'

# Use Puma as the app server
gem 'puma', '~> 3.7'

gem 'acts_as_api'
gem 'devise'
gem 'devise-jwt', '~> 0.3.0'

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'spring'
  gem 'sqlite3'
end

group :production do
  gem 'pg', '~> 0.18'
end

group :test do
  gem 'airborne'
  gem 'rspec-rails'
end
