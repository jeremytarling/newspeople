source "http://rubygems.org"
gem "rails", "2.3.14"
gem 'rake', '0.8.7'
gem 'rest-client'
gem 'json'

group :development do
  gem "mysql"
  gem "taps", :require => false # has an sqlite dependency, which heroku hates
end

group :production do
  gem "pg"
end