

require 'rails/all'
require 'ammeter/init'
require 'rails-controller-testing'
# Rspec is missing an include for this somewhere
require 'rspec/core/formatters/console_codes'
require 'generators/reactify/generators/install_generator'

Rails::Controller::Testing.install

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :controller

  config.after :suite do
    Reactify::Specs::Generators.remove_dummy_app
  end
end


