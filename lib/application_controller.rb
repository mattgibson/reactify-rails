# This file monkey patches ApplicationController so that the default
# render when there is a controller action without a template is the
# SPA.

require 'open3'
require 'reactify/node_renderer'

class ApplicationController < ActionController::Base
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
    respond_to do |format|
      begin
        @reactify_view_assigns = view_assigns.to_json

        renderer = Reactify::NodeRenderer.new renderer_filename: reactify_renderer_filename

        @reactify_pre_rendered_html = renderer.render_app(controller_json: @reactify_view_assigns)

      rescue => e
        @reactify_pre_rendered_html = e.to_s
        #  Here, we are already in a rescue block because of rescue_from,
        #  so re-raising the error is ignored.
      end

      format.html { render 'reactify/spa' }
    end
  end

  private

  def reactify_renderer_filename
    Rails.root.join 'webpack', 'server_renderer.jsx'
  end

  def reactify_end_of_data_delimiter
    '__REACTIFY_END__'
  end
end
