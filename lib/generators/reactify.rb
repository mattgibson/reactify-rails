module Reactify
  # @private
  module Generators
    # @private
    class Base < ::Rails::Generators::NamedBase
      include RSpec::Rails::FeatureCheck

      def self.source_root(path = nil)
        if path
          @_rspec_source_root = path
        else
          @_rspec_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'reactify', generator_name, 'templates'))
        end
      end

      if ::Rails::VERSION::STRING < '3.1'
        def module_namespacing
          yield if block_given?
        end
      end
    end
  end
end
