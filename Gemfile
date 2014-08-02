source "https://rubygems.org"
ruby "2.1.1"

gem "bcrypt"
gem "bootstrap-sass"
gem "bootstrap_form"
gem "coffee-rails"
gem "haml-rails"
gem "jquery-rails"
gem "paratrooper"
gem "rails", "4.1.1"
# gem "sass-rails"
gem "sidekiq"
gem "sinatra", require: false
gem "slim"
gem "uglifier"
gem "unicorn"

group :development do
  gem "annotate"
  gem "awesome_print"
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "meta_request"
  gem "paratrooper"
  gem "sqlite3"
  gem "thin"
end

group :development, :test do
  gem "factory_girl_rails", "~> 4.2.1"
  gem "faker"
  gem "fixture_builder"
  gem "jazz_hands"

  #remove if jazz_hands works better
  # gem "pry-debugger"
  # gem "pry-nav"
  # gem "pry-rails"

  gem "quiet_assets"
  gem "rspec-rails", "2.99"
end

group :test do
  gem "capybara", require: false
  gem "capybara-email", github: "dockyard/capybara-email"
  gem "cucumber-rails", require: false
  gem "database_cleaner", "1.2.0"
  gem "launchy"
  gem "rake"          #for travis ci
  gem "selenium-webdriver", require: false
  gem "shoulda-matchers"
end

group :production do
  gem "pg"
  gem "rails_12factor"
  gem "sentry-raven"
end

