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

        puts 'Adding rescue block to ApplictionController'
        inject_into_file file_path,
                         after: "class ApplicationController < ActionController::Base\n" do
          <<-RUBY
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
     render 'reactify/spa'
  end

          RUBY
        end
      end

      def make_package_json
        puts 'Adding package.json for npm...'
        copy_file 'package.json', 'package.json'
      end

      def npm_install
        if options['without-npm']
          puts 'Skipping npm install because --without-npm option was passed'
          return
        end
        puts 'Installing npm packages...'
        Dir.chdir(destination_root) do
          puts `npm install`
        end
      end

      def add_webpack_config
        puts 'Adding Webpack config files...'
        copy_file 'webpack.base.config.js', 'config/webpack.base.config.js'
        copy_file 'webpack.prod.config.js', 'config/webpack.prod.config.js'
        copy_file 'webpack.dev.config.js', 'config/webpack.dev.config.js'
      end

      def add_procfile
        puts 'Adding Procfile...'
        copy_file 'Procfile', 'Procfile'
      end
    end
  end
end
