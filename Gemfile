source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt"
gem "bootstrap-sass", "~> 3.3.7"
gem "config"
gem "coffee-rails", "~> 4.2"
gem "figaro"
gem "font-awesome-rails"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails", "~> 4.3", ">= 4.3.1"
gem "mysql2", ">= 0.3.18", "< 0.5"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.6"
gem "rails-i18n", "~> 5.1"
gem "sass-rails", "~> 5.0"
gem "omniauth"
gem "omniauth-facebook"
gem "uglifier", ">= 1.3.0"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "faker", "~> 1.8", ">= 1.8.7"
gem "paperclip", "~> 6.0.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "pry-rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "rubocop", "~> 0.55.0", require: false
end
