source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'simple_form'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :develop, :test do
  gem 'debugger'
  gem 'sqlite3'
end

group :develop do
  gem 'guard'
  gem 'guard-test'
  gem 'guard-bundler'

  # OS X toys
  gem 'rb-fsevent', require: false
  gem 'terminal-notifier-guard', require: false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'launchy'
end

  
        
