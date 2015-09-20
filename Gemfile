source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use sqlite3 as the database for Active Record in dev, Postgres in production
gem 'pg'
gem 'sqlite3'
# Utilize paranoia, which enables soft delets in Active Record
gem "paranoia", "~> 2.0"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use Toastr for notifications
gem 'toastr-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# FontAwesome for icons
gem 'font-awesome-rails'
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Devise for user authentication
gem 'devise'
# Active Admin for the admin interface
gem 'activeadmin', github: 'activeadmin'
# paperclip for file upload for logos
gem 'paperclip'
# Twitter Bootstrap
gem 'bootstrap-sass', '~> 3.3.4'
#debug helper
gem "awesome_print"

# annotate puts comments on the schema of the models
gem 'annotate'

group :development do
	# Guard runs rspec on file changes
	gem 'guard-rspec', require: false
end

group :development, :test do
  	# Mock model data with Factory_Girl
  	gem 'factory_girl_rails'
  	# Fuzz and generate random fake data
  	gem 'faker'
  	# run tests with RSpec
  	gem 'rspec-rails', '~> 3.0'
end

# CodeClimate test reporting
gem "codeclimate-test-reporter", group: :test, require: nil