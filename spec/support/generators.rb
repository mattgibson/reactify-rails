module Reactify
  module Specs
    module Generators
      extend ActiveSupport::Concern

      module ClassMethods
        def set_default_destination
          destination File.expand_path("../../tmp", __FILE__)
        end

        def setup_default_destination
          set_default_destination
          before do
            prepare_destination

            # Copy the application controller file into the destination folder
            # So that the generator has something to work with.
            destination_path = File.expand_path('app/controllers', destination_root)
            FileUtils.mkdir_p destination_path
            source_path = File.expand_path('app/controllers/application_controller.rb',
                                           Reactify::Specs::Generators.dummy_app_template_path)
            FileUtils.cp File.expand_path(source_path, __FILE__), destination_path
          end
          after(:all) { prepare_destination }
        end
      end

      # These methods allow us to copy the dummy app template to the dummy
      # folder and run the generator on it. We want to re-do this each time
      # we run the tests in case we have changed the generator in the meantime.

      module_function

      def dummy_app_template_path
        File.join(File.dirname(__FILE__), '../dummy_template')
      end

      def dummy_app_path
        File.join(File.dirname(__FILE__), '../dummy')
      end

      def create_fresh_dummy_app
        FileUtils.cp_r dummy_app_template_path,
                       dummy_app_path,
                       remove_destination: true
      end

      def remove_dummy_app
        FileUtils.rm_r dummy_app_path if File.directory? dummy_app_path
      end
    end
  end
end

RSpec.configure do |config|
  config.include Reactify::Specs::Generators
end
