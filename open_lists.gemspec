$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "open_lists/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "Open Lists"
  s.version     = OpenLists::VERSION
  s.authors     = ["L.Briais"]
  s.email       = ["lbnetid+rb@gmail.com"]
  s.homepage    = "https://github.com/lbriais/open_lists"
  s.summary     = "Provides a generic UI for database tables."
  s.description = "Open Lists enables to manipulate tables in the database that have been introspected by database_introspection gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"
  s.add_dependency 'sass-rails',   '~> 3.2.3'
  s.add_dependency 'coffee-rails', '~> 3.2.1'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'bootstrap-sass', '~> 2.3.1.0'
  s.add_dependency 'uglifier', '>= 1.0.3'
  s.add_dependency 'kaminari'

  s.add_development_dependency "sqlite3"
end
