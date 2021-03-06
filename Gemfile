source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0'
# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library

gem 'jquery-rails'



# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "asset_sync"
gem "redactor-rails", git: "https://github.com/SammyLin/redactor-rails.git"
gem "simple_form", git: "git://github.com/plataformatec/simple_form.git"
gem "compass-rails", github: "Compass/compass-rails", branch: "master"
gem "sitemplate_core", git: "git@gitlab.httplab.ru:sitemplate/sitemplate_core.git", branch: "master"
gem 'http_accept_language', git: 'git://github.com/DouweM/http_accept_language.git', branch: 'no-middleware-no-crash'
gem 'globalize', '~> 4.0'
gem 'gon', '4.1.1'
gem 'chart-js-rails'

group :production do
  gem "unicorn"
  gem "daemons"
  gem "whenever", require: false
  gem "exception_notification", "~> 4.0.1"
end

group :development do
  gem "capistrano"
  #require "capistrano"
  gem "capistrano-ext"
  gem "rvm-capistrano"
  gem "capistrano_colors"
  gem 'capistrano-unicorn', require: false
  gem "letter_opener"
  gem "better_errors"
  gem "binding_of_caller"
  gem 'quiet_assets'
end

group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem "rails_best_practices"
  gem "shoulda-matchers", require: false
  gem "capybara"
end

group :test do
  gem "simplecov", require: false
end
