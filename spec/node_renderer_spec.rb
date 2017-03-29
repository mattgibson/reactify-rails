require 'spec_helper'
require 'reactify/node_renderer'

RSpec.describe Reactify::NodeRenderer do
  let(:node_path) do
    File.expand_path '../dummy/node_modules', __FILE__
  end
  let(:renderer) { described_class.new renderer_filename: renderer_path, node_path: node_path }
  after { renderer.shutdown }

  context 'with a working renderer' do
    let(:renderer_path) do
      File.expand_path '../support/renderers/working_server_renderer.jsx', __FILE__
    end

    it 'renders correctly' do
      output = renderer.render_app
      expect(output).to include 'Hello world!'
    end

    it 'passes through JSON correctly' do
      json_data = { thing: 'value' }.to_json
      output = renderer.render_app controller_json: json_data
      expect(output).to include 'thing:value'
    end
  end

  context 'with a syntax error in the renderer' do
    let(:renderer_path) do
      File.expand_path '../support/renderers/broken_server_renderer.jsx', __FILE__
    end

    it 'repairs the node connection after a bad render' do
      renderer.render_app
      output = renderer.render_app
      expect(output).to include 'Syntax error!'
    end
  end
end
