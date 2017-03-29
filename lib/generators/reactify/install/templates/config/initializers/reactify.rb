module Reactify
  # Config values needed:

  # The server renderer filename (default to webpack/server_renderer.jsx)

  # The size of the node worker pool

  def self.set_up_node_renderer_pool
    @@node_renderers = ConnectionPool::Wrapper.new(size: 2, timeout: 5) do
      Reactify::NodeRenderer.new
    end
  end
end
