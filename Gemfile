source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "active_storage_validations"
gem "aws-sdk-s3"
gem "bootsnap", require: false
gem "cssbundling-rails"
gem "devise"
gem "devise-i18n"
gem "dotenv-rails"
gem "image_processing", ">= 1.2"
gem "jbuilder"
gem "jsbundling-rails"
gem "mailjet"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.3"
gem "rails-i18n", "~> 7.0.0"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "letter_opener"
  gem "web-console"
end

group :production do
  gem "pg"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
