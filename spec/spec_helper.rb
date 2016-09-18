require 'rails/all'
require 'ammeter/init'

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
