require 'rails/generators'

module Reactify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def add_spa_template
        puts 'Adding default SPA template to Rails...'
        copy_file 'reactify_spa.html.erb', 'app/views/reactify/spa.html.erb'
      end

      def add_rescue_block_to_application_controller
        inject_into_file 'app/controllers/application_controller.rb',
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
