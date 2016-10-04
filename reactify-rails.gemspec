$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reactify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reactify-rails"
  s.name        = "reactify-rails"
  s.version     = Reactify::VERSION
  s.authors     = ["Matt Gibson"]
  s.email       = ["downrightlies@gmail.com"]
  s.summary     = "Generates a React single page app using WebPack"
  s.description = "Reactify adds WebPack to Rails, bypassing Sprockets entirely "\
                  "so that JavaScript is a first class citizen in your app, with "\
                  "libraries loaded from npm. The SPA will be served automatically "\
                  "by your app any time there is no template provided in the views "\
                  "directory and and uses server side rendering. A mechanism is "\
                  "provided which allow data to be passed from the controller to "\
                  "the SPA so that the redux store can be pre-hydrated with whatever "\
                  "data the page needs, allowing for a truly [universal/ispomorphic] "\
                  "app."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0"

  s.add_development_dependency "rspec"
  s.add_development_dependency "ammeter"
  s.add_development_dependency "sqlite3", ">= 1"
  s.add_development_dependency "rails-controller-testing"

  s.required_ruby_version = "~> 2.2.3"
end
