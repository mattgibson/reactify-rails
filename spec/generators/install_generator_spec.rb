require 'spec_helper'
require 'generators/reactify/generators/install_generator'

describe Reactify::Generators::InstallGenerator, type: :generator do
  setup_default_destination

  describe 'creating the HTML view for the SPA' do
    subject { file('app/views/reactify/spa.html.erb') }

    before { run_generator }

    it { is_expected.to exist }
  end

  describe 'adding the default render to application controller' do
    before do
      # Put the application controller file into the destination folder
      dest = File.expand_path('app/controllers', destination_root)
      FileUtils.mkdir_p dest
      FileUtils.cp File.expand_path('../../dummy/app/controllers/application_controller.rb', __FILE__),
                   dest
      run_generator
    end

    subject { file('app/controllers/application_controller.rb') }

    it 'contains the rescue block' do
      expect(subject).to contain <<-RUBY
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
     render 'reactify/spa'
  end

      RUBY
    end
  end
end
