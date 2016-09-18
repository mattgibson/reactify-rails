require 'rails/generators'

module Reactify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def install
        copy_file 'reactify_spa.html.erb', 'app/views/reactify_spa.html.erb'
      end
    end
  end
end
