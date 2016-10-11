require 'rails/all'
require 'ammeter/init'
require 'rails-controller-testing'
# Rspec is missing an include for this somewhere
require 'rspec/core/formatters/console_codes'
require 'generators/reactify/generators/install_generator'

Rails::Controller::Testing.install

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

dummy_path = File.join(File.dirname(__FILE__), 'dummy_template')
tmp_path = File.join(File.dirname(__FILE__), 'dummy')

RSpec.configure do |config|
  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :controller

  config.after :suite do
    FileUtils.remove_entry_secure tmp_path, verbose: true
  end
end

# Get a Rails dummy app ready that already has the install generator run.
FileUtils.cp_r dummy_path, tmp_path, verbose: true, remove_destination: true
Reactify::Generators::InstallGenerator.start([], { destination_root: tmp_path })
