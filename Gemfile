source "http://rubygems.org"

gem "rails", "3.1.1"
gem "mysql2"

# Template engine.
gem "haml"

# Simplify the creation of forms.
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'

# Add sugar to ActiveRecord API.
gem "squeel"

# Define default values for models.
gem "default_value_for" 

# Get only few properties from models without instantiate them.
gem "valium"

# Handle background and delayed jobs.
gem "resque"
gem "resque-scheduler"
gem "resque-jobs-per-fork"

# Needed to use "has_secure_password"
gem 'bcrypt-ruby', '~> 3.0.0'

# Push server.
# gem "juggernaut"
gem "juggernaut", :git => "git://github.com/Sephi-Chan/juggernaut.git"

# Build JSON views.
gem 'rabl'
gem 'yajl-ruby'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails"
  gem "coffee-rails"
  gem "uglifier"
end

gem "jquery-rails"

# Use unicorn as the web server
# gem "unicorn"

# Deploy with Capistrano
# gem "capistrano"

# To use debugger
# gem "ruby-debug19", :require => "ruby-debug"

group :development, :test do
  gem "awesome_print"
  gem "rspec-rails"
  gem "cucumber-rails"
  gem "database_cleaner"
  gem "factory_girl"
  gem "factory_girl_rails"
end
