require 'application_controller'
require 'connection_pool'

module Reactify
  def self.node_renderer
    @@node_renderer ||= ConnectionPool::Wrapper.new(size: number_of_workers) do
      Reactify::NodeRenderer.new renderer_filename: renderer_file
    end
  end

  def self.wipe_out_renderer_pool
    node_renderer.shutdown { |renderer| renderer.shutdown }
    @@node_renderer = nil
  end

  def self.renderer_file
    Rails.root.join 'reactify', 'server_renderer.jsx'
  end

  def self.number_of_workers
    1
  end
end
