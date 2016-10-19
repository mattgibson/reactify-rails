require 'rails_helper'
require 'generators/reactify/generators/install_generator'

describe Reactify::Generators::InstallGenerator, type: :generator do
  describe 'creating the HTML view for the SPA' do
    subject { file_in_dummy_app('app/views/reactify/spa.html.erb') }

    it { is_expected.to exist }
  end

  describe 'adding the default render to application controller' do
    subject { file_in_dummy_app('app/controllers/application_controller.rb') }

    it 'contains the rescue block' do
      expect(subject).to contain <<-RUBY
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
     render 'reactify/spa'
  end

      RUBY
    end
  end

  describe 'npm' do
    describe 'creating package.json' do
      subject { file_in_dummy_app('package.json') }

      it { is_expected.to exist }
    end

    describe 'running npm' do
      subject { file_in_dummy_app('node_modules') }

      it { is_expected.to exist }
    end

    describe 'installing react' do
      subject { file_in_dummy_app('node_modules/react') }

      it { is_expected.to exist }
    end

    describe 'installing redux' do
      subject { file_in_dummy_app('node_modules/redux') }

      it { is_expected.to exist }
    end
  end

  describe 'adding the procfile' do
    subject { file_in_dummy_app('Procfile') }

    it { is_expected.to exist }

    it 'contains the right directives' do
      expect(subject).to contain <<-RUBY
web: bundle exec rails s
webpack: npm run webpack
      RUBY
    end
  end

  describe 'webpack config files' do
    describe 'production config' do
      subject { file_in_dummy_app('config/webpack.prod.config.js') }

      it { is_expected.to exist }
    end

    describe 'development config' do
      subject { file_in_dummy_app('config/webpack.dev.config.js') }

      it { is_expected.to exist }
    end

    describe 'base config' do
      subject { file_in_dummy_app('config/webpack.base.config.js') }

      it { is_expected.to exist }
    end
  end
end
