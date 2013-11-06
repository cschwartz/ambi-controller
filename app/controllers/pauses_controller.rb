class PausesController < ApplicationController
  def update
    is_paused = params[:paused] == 1
    configuration.pause(is_paused)
    render nothing: true
  end
end
