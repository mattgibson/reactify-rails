module Reactify
  module Specs
    module Generators
      def file_in_dummy_app(path)
        File.expand_path path, dummy_app_path
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
        File.chmod(0777, File.join(File.dirname(__FILE__), '..'))
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
