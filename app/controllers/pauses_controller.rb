class PausesController < ApplicationController
  def update
    is_paused = params[:paused] == true
    configuration.pause(is_paused)
    render nothing: true
  end
end
