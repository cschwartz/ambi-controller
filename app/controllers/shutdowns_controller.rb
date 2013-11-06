class ShutdownsController < ApplicationController
  def update
    do_shutdown = params[:shutdown] == 1
    configuration.shutdown(do_shutdown)
    render nothing: true
  end
end

