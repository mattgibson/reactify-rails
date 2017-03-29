# This file monkey patches ApplicationController so that the default
# render when there is a controller action without a template is the
# SPA.

require 'reactify/node_renderer'

class ApplicationController < ActionController::Base
  rescue_from ActionView::MissingTemplate, ActionController::UnknownFormat do
    respond_to do |format|
      begin
        @reactify_view_assigns = view_assigns.to_json

        @reactify_pre_rendered_html = Reactify.node_renderer.with do |renderer|
          renderer.render_app(controller_json: @reactify_view_assigns)
        end
      rescue => e
        @reactify_pre_rendered_html = "Error raised: #{e.class.name}\n#{e.message}\n#{e.backtrace.join("\n")}"
        Reactify.wipe_out_renderer_pool

        # Here, we are already in a rescue block because of rescue_from,
        # so re-raising the error from the renderer doesn't work. It will be ignored and the
        # missing template error will get re-raised by Rails.
      end

      format.html { render 'reactify/spa' }
    end
  end

  private

  def reactify_renderer_filename
    Rails.root.join 'reactify', 'server_renderer.jsx'
  end

  def reactify_end_of_data_delimiter
    '__REACTIFY_END__'
  end
end
