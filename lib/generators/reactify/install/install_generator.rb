require 'rails/generators'
require 'execjs'

module Reactify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      class_option 'without-npm', type: :boolean, default: false, lazy_default: true

      def copy_templates
        Dir["#{File.dirname(__FILE__)}/templates/**/*"].each do |path|
          next if File.directory? path
          relative_path =  path.gsub("#{File.dirname(__FILE__)}/templates/", '')
          copy_file relative_path, relative_path
        end
      end

      def npm_install
        if options['without-npm']
          puts 'Skipping npm install because --without-npm option was passed'
          return
        end
        if `yarn --version  2>&1` =~ /not found/
          puts 'Installing Yarn...'
          puts `npm install -g yarn --ignore-scripts`
        end
        puts 'Installing npm packages with yarn...'
        Dir.chdir(destination_root) do
          puts `yarn install`
        end
      end
    end
  end
end
