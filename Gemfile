source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# my gems developed for this application
git 'https://github.com/ciaranCBbyrne/rubygems.git' do
	# use maths gem to generate questions for the application
	gem 'maths', '~> 1.0.1'
	# use levelgem to check the users level of competence
	gem 'levelgem', '~> 1.0.1'
	# use mathshelper to give user guidelines on how to solve equations
	gem 'mathshelper'
	# use creditgem to give the user a rating based on the level attained
	gem 'creditgem'
end

# include external gem from brian martin
git 'https://github.com/brianjgmartin/rubyGems.git' do
	# use congrats gem to give user breakdown of level when they've completed it
	gem 'congrats'
end

# Use the devise and twitter-bootstrap-rails gems from rubygems.org
# devise provides log-in and registration to application
gem 'devise'
# twitter-bootstrap-rails generates styling to application
gem 'twitter-bootstrap-rails'
