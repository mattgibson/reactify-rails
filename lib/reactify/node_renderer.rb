module Reactify
  class NodeRenderer
    def initialize(renderer_filename:)
      @stdin, @stdout_stderror = Open3.popen2e node_command(renderer_filename)
    end

    def render_app(controller_json:)
      stdin.puts controller_json
      stdin.puts reactify_end_of_data_delimiter
      return_rendered_response
    end

    def shutdown
      stdin.close
      stdout_stderror.close
    end

    private

    attr_reader :stdin, :stdout_stderror

    # NOE_PATH is needed here so that node uses the app node modules instead of
    # looking in the gem and not finding all the modules.
    def node_command(renderer_filename)
      <<~TEXT.squish
        NODE_PATH=#{Rails.root}/node_modules 
        node #{node_listener_filename} 
          --renderer #{renderer_filename}
          --delimiter #{reactify_end_of_data_delimiter}
      TEXT
    end

    def return_rendered_response
      pre_rendered_html = ''
      while (line = @stdout_stderror.gets) && !/#{reactify_end_of_data_delimiter}/.match?(line) do
        pre_rendered_html += line
      end
      pre_rendered_html
    rescue => e
      e.to_s
    end

    def reactify_end_of_data_delimiter
      '__REACTIFY_END__'
    end

    def node_listener_filename
      "#{File.dirname(__FILE__)}/../js/server_render_listener.js"
    end
  end
end
