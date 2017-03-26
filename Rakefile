begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Reactify::Rails'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'bundler/gem_tasks'

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :copy_files_to_dummy do
  require 'rails/generators'

  dummy_app_path = File.join(File.dirname(__FILE__), 'spec/dummy')
  webpack_path ="#{dummy_app_path}/webpack"
  views_path ="#{dummy_app_path}/app/views"

  FileUtils.rm_r webpack_path if File.directory? webpack_path
  FileUtils.rm_r views_path if File.directory? views_path


  Rails::Generators.invoke('reactify:install', ['--without-npm'], {
    destination_root: File.join(File.dirname(__FILE__), 'spec/dummy')
  })
end
