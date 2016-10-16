require 'rails/generators'

module Reactify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def add_spa_template
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
        copy_file 'package.json', 'package.json'
      end

      def install_react
        Dir.chdir(destination_root) do
          puts `npm install --save react`
        end
      end
    end
  end
end
