require 'rails_helper'
require 'generators/reactify/install/install_generator'

describe Reactify::Generators::InstallGenerator, type: :generator do
  describe 'creating the HTML view for the SPA' do
    subject { file_in_dummy_app('app/views/reactify/spa.html.erb') }

    it { is_expected.to exist }
  end

  describe 'npm' do
    before :all do
      Reactify::Specs::Generators.run_npm_generator
    end

    describe 'creating package.json' do
      subject { file_in_dummy_app('package.json') }

      it { is_expected.to exist }
    end

    describe 'creating yarn.lock' do
      subject { file_in_dummy_app('yarn.lock') }

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

    describe 'running the postinstall task' do
      subject { file_in_dummy_app('public/webpack/reactify_bundle.js') }

      it { is_expected.to exist }
    end
  end

  describe 'adding the procfile' do
    subject { file_in_dummy_app('Procfile') }

    it { is_expected.to exist }

    it 'contains the right directives' do
      expect(subject).to contain <<-RUBY
web: bundle exec rails s -p 3000
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

  describe 'webpack folder' do
    describe 'the reactify_spa.jsx file' do
      subject { file_in_dummy_app('webpack/client_renderer.jsx') }

      it { is_expected.to exist }
    end

    describe 'the server_render.jsx file' do
      subject { file_in_dummy_app('webpack/server_renderer.jsx') }

      it { is_expected.to exist }
    end

    describe 'the redux store' do
      subject { file_in_dummy_app('webpack/redux/store/index.js')}

      it { is_expected.to exist }
    end

    describe 'the reducers' do
      subject { file_in_dummy_app('webpack/redux/reducers/index.js') }

      it { is_expected.to exist }
    end
  end
end
