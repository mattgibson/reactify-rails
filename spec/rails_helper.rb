require 'spec_helper'

# Get a Rails dummy app ready that already has the install generator run. We
# want to run the generator again on a fresh install of the dummy app each time
# as the generator code may have changed.
Reactify::Specs::Generators.create_fresh_dummy_app
Reactify::Generators::InstallGenerator.start([], {
  destination_root: Reactify::Specs::Generators.dummy_app_path
})

require File.expand_path('config/environment.rb',
                         Reactify::Specs::Generators.dummy_app_path)
