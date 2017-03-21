require 'rails/generators'
require 'execjs'

module Reactify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      class_option 'without-npm', type: :boolean, default: false, lazy_default: true

      def add_rescue_block_to_application_controller
        file_path = 'app/controllers/application_controller.rb'
        return if File.readlines(File.join(destination_root, file_path)).grep(/reactify/).any?

        puts 'Adding rescue block to ApplicationController'

        inject_into_file file_path, after: /\A/ do
          "require 'open3'\n\n"
        end

        inject_into_file file_path,
                         after: "class ApplicationController < ActionController::Base\n" do
          <<-RUBY
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
    respond_to do |format|
      filename = Rails.root.join 'webpack', 'server_render_listener.js'
      the_js = ''

      begin
        stdin, stdout_stderror = Open3.popen2e "node \#{filename}"

        stdin.puts view_assigns
        stdin.puts '__END__'

        while (line = stdout_stderror.gets) && !/__END__/.match?(line) do
          the_js += line
        end

      rescue => e
        the_js += e.to_s
        # Already in a rescue block because of rescue_from, so re-raise is ignored.
      end

      format.html { render html: the_js }
    end
  end

          RUBY
        end
      end

      def copy_templates
        Dir["#{File.dirname(__FILE__)}/templates/**/*.*"].each do |path|
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
          puts `yarn install --ignore-scripts`
        end
      end
    end
  end
end
