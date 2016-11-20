require 'rails/generators'

module Reactify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      class_option 'without-npm', type: :boolean, default: false, lazy_default: true

      def add_spa_template
        puts 'Adding default SPA template to Rails...'
        copy_file 'reactify_spa.html.erb', 'app/views/reactify/spa.html.erb'
      end

      def add_rescue_block_to_application_controller
        file_path = 'app/controllers/application_controller.rb'
        return if File.readlines(File.join(destination_root, file_path)).grep(/reactify/).any?

        puts 'Adding rescue block to ApplicationController'
        inject_into_file file_path,
                         after: "class ApplicationController < ActionController::Base\n" do
          <<-RUBY
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
    respond_to do |format|
      @view_assigns = view_assigns
      format.html { render 'reactify/spa' }
    end
  end

          RUBY
        end
      end

      def copy_components_to_webpack_folder
        puts 'Creating react components...'
        copy_file 'components/hello-world.jsx', 'webpack/components/hello-world.jsx'
      end

      def make_package_json
        puts 'Adding package.json for npm...'
        copy_file 'package.json', 'package.json'
        copy_file 'yarn.lock', 'yarn.lock'
      end

      def add_webpack_config
        puts 'Adding Webpack config files...'
        copy_file 'config/webpack.base.config.js', 'config/webpack.base.config.js'
        copy_file 'config/webpack.prod.config.js', 'config/webpack.prod.config.js'
        copy_file 'config/webpack.dev.config.js', 'config/webpack.dev.config.js'
      end

      def add_procfile
        puts 'Adding Procfile...'
        copy_file 'Procfile', 'Procfile'
      end

      def make_webpack_folder
        copy_file 'reactify_spa.jsx', 'webpack/reactify_spa.jsx'
      end

      def npm_install
        if options['without-npm']
          puts 'Skipping npm install because --without-npm option was passed'
          return
        end
        if `yarn --version  2>&1` =~ /not found/
          puts 'Installing Yarn...'
          puts `npm install -g yarn`
        end
        puts 'Installing npm packages with yarn...'
        Dir.chdir(destination_root) do
          puts `yarn install`
        end
      end
    end
  end
end
