source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt"
gem "bootstrap-sass", "~> 3.3.7"
gem "ckeditor"
gem "config"
gem "coffee-rails", "~> 4.2"
gem "delayed_job_active_record"
gem "faker"
gem "figaro"
gem "font-awesome-rails"
gem "i18n-js"
gem "jquery-infinite-pages"
gem "jbuilder", "~> 2.5"
gem "jquery-rails", "~> 4.3", ">= 4.3.1"
gem "kaminari"
gem "mini_magick", "4.7.0"
gem "mysql2", ">= 0.3.18", "< 0.5"
gem "puma", "~> 3.7"
gem "paperclip"
gem "rails", "~> 5.1.6"
gem "rails-i18n", "~> 5.1"
gem "sass-rails", "~> 5.0"
gem "omniauth"
gem "omniauth-facebook"
gem "whenever", require: false
gem "uglifier", ">= 1.3.0"
gem "sidekiq"
gem "faker"
gem "rails-controller-testing"

group :development, :test do
  gem "rspec-rails", "~> 3.7"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "pry-rails"
end

group :development do
  gem "rspec-rails", "~> 3.7"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "factory_bot_rails"
  gem "rubocop", "0.47.1", require: false
  gem 'database_cleaner', '~> 1.5'
end
