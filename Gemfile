# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'autoprefixer-rails'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'font-awesome-sass'
gem 'jbuilder', '~> 2.7'
gem 'mutations', '~> 0.9.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3'
gem 'redis', '~> 4.0'
gem 'rest-client', '~> 2.1'
gem 'sass-rails', '>= 6'
gem 'simple_form'
gem 'themoviedb'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
gem 'cloudinary', '~> 1.16.0'

group :development, :test do
  gem 'brakeman' # https://github.com/presidentbeef/brakeman
  gem 'bundler-audit' # https://github.com/rubysec/bundler-audit
  gem 'dotenv-rails'
  gem 'fabrication', '~> 2.21', '>= 2.21.1' # https://github.com/paulelliott/fabrication
  gem 'faker', '~> 2.13' # https://github.com/faker-ruby/faker
  gem 'pry-byebug' # https://github.com/deivid-rodriguez/pry-byebug
  gem 'pry-clipboard' # https://github.com/hotchpotch/pry-clipboard
  gem 'pry-rails' # https://github.com/rweng/pry-rails
  gem 'rspec-rails' # https://github.com/rspec/rspec-rails

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'annotate' # https://github.com/ctran/annotate_models
  gem 'rubocop' # https://github.com/rubocop-hq/rubocop
  gem 'rubocop-rails' # https://github.com/rubocop-hq/rubocop-rails
  gem 'rubocop-rspec', '~> 2.0.0.pre' # https://github.com/rubocop-hq/rubocop-rspec
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
