source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "active_storage_validations"
gem "aws-sdk-s3"
gem "bcrypt_pbkdf", ">= 1.0", "< 2.0"
gem "bootsnap", require: false
gem "cssbundling-rails"
gem "devise"
gem "devise-i18n"
gem "dotenv-rails"
gem "ed25519", ">= 1.2", "< 2.0"
gem "image_processing", ">= 1.2"
gem "jbuilder"
gem "jsbundling-rails"
gem "mailjet"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-rails_csrf_protection"
gem "omniauth-vkontakte"
gem "puma", "~> 5.0"
gem "pundit", "~> 1.1"
gem "rails", "~> 7.0.3"
gem "rails-i18n", "~> 7.0.0"
gem 'resque', '~> 2.2'
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails"
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-bundler", "~> 2.0"
  gem "capistrano-passenger"
  gem "capistrano-rails", "~> 1.3", require: false
  gem "capistrano-resque", "~> 0.2.3", require: false
  gem "capistrano-rvm"
  gem "letter_opener"
  gem "web-console"
end

group :production do
  gem "pg"
end

group :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "selenium-webdriver"
  gem "webdrivers"
end
