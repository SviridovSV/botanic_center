# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'aasm'
gem 'bootstrap-sass'
gem 'cancancan'
gem 'carrierwave'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'draper'
gem 'ffaker'
gem 'figaro'
gem 'fog-aws'
gem 'haml', '>= 5.0.2'
gem 'haml-rails', '>= 1.0.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.2'
gem 'rails_admin'
gem 'rails_admin_aasm'
gem 'rubocop', '~> 0.49.1', require: false
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'wicked'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '2.4.1'
