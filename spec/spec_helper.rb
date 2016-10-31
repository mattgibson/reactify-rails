require 'rails/all'
require 'rspec/core'
require 'rails-controller-testing'
# Rspec is missing an include for this somewhere
require 'rspec/core/formatters/console_codes'
require 'generators/reactify/install//install_generator'
require 'ammeter'

Rails::Controller::Testing.install

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }


