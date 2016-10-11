require 'rails/generators'

module Reactify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def install
        copy_file 'reactify_spa.html.erb', 'app/views/reactify/spa.html.erb'

        inject_into_file 'app/controllers/application_controller.rb',
                         after: "class ApplicationController < ActionController::Base\n" do
          <<-RUBY
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
     render 'reactify/spa'
  end

          RUBY
        end
      end
    end
  end
end
