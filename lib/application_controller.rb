# This file monkey patches ApplicationController so that the default
# render when there is a controller action without a template is the
# SPA.

require 'open3'

class ApplicationController < ActionController::Base
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
    respond_to do |format|
      begin
        stdin, stdout_stderror = Open3.popen2e "node #{reactify_node_listener_filename}"

        @reactify_view_assigns = view_assigns.to_json

        stdin.puts @reactify_view_assigns
        stdin.puts reactify_end_of_data_delimiter # Tells the node process to render, then reset

        @reactify_pre_rendered_html = ''
        while (line = stdout_stderror.gets) && !/#{reactify_end_of_data_delimiter}/.match?(line) do
          @reactify_pre_rendered_html += line
        end
      rescue => e
        @reactify_pre_rendered_html = e.to_s
        # Here, we are already in a rescue block because of rescue_from,
        # so re-raising the error is ignored.
      end

      format.html { render 'reactify/spa' }
    end
  end

  private

  def reactify_node_listener_filename
    Rails.root.join 'webpack', 'server_render_listener.js'
  end

  def reactify_end_of_data_delimiter
    '__REACTIFY_END__'
  end
end
