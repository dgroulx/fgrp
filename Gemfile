source 'https://rubygems.org'

gem 'rails', '3.2.8'

group :assets do
  gem 'therubyracer'
  gem 'libv8'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'simple_form'
gem 'devise'
gem 'cancan'
gem 'redcarpet'

gem 'capistrano'

group :development, :test do
  gem 'sqlite3'
end

gem 'mysql2'

group :development do
  gem 'guard'
  gem 'guard-test'
  gem 'guard-bundler'

  # OS X toys
  gem 'rb-fsevent', :require => false
  gem 'terminal-notifier-guard', :require => false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'launchy'
end
