require 'spec_helper'
require 'generators/reactify/generators/install_generator'

describe Reactify::Generators::InstallGenerator, type: :generator do
  setup_default_destination

  subject { file('app/views/reactify_spa.html.erb') }

  before { run_generator }

  it { is_expected.to exist }
end
