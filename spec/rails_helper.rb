require 'spec_helper'
require_relative 'create_rails_from_template'
# This needs Rails to be already in place in /dummy so that it can load stuff
# and set up routes for capybara.
require 'rspec/rails'

require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :controller

  config.after :suite do
    Reactify::Specs::Generators.remove_dummy_app
  end
end
