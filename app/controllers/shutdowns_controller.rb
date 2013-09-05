class ShutdownsController < ApplicationController
  def update
    do_shutdown = params[:shutdown] == true
    configuration.shutdown(do_shutdown)
    render nothing: true
  end
end

