source "https://rubygems.org"
ruby "2.1.1"

gem "bcrypt"
gem "bootstrap-sass"
gem "bootstrap_form"
gem "carrierwave"
gem "carrierwave_backgrounder"
gem "coffee-rails"
gem "fog"
gem "haml-rails"
gem "high_voltage"
gem "jquery-rails"
gem "mini_magick"
gem "paratrooper"
gem "rails", "4.1.1"
# gem "sass-rails"
gem "sidekiq"
gem "sinatra", require: false
gem "slim"
gem "stripe", :git => "https://github.com/stripe/stripe-ruby"
gem "uglifier"
gem "unicorn"

group :development do
  gem "annotate"
  gem "awesome_print"
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "meta_request"
  gem "sqlite3"
  gem "thin"
end

group :development, :test do
  gem "dotenv-rails"
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
  gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
end

