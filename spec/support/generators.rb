module Reactify
  module Specs
    module Generators
      module Macros
        def set_default_destination
          destination File.expand_path("../../../tmp", __FILE__)
        end

        def setup_default_destination
          set_default_destination
          before do
            prepare_destination

            # Put the application controller file into the destination folder
            dest = File.expand_path('app/controllers', destination_root)
            FileUtils.mkdir_p dest
            FileUtils.cp File.expand_path('../../dummy/app/controllers/application_controller.rb', __FILE__),
                         dest
          end
          after(:all) { prepare_destination }
        end
      end

      def self.included(klass)
        klass.extend Macros
      end
    end
  end
end

RSpec.configure do |config|
  config.include Reactify::Specs::Generators, type: :generator
end
