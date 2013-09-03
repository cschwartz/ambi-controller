class CurrentProgramsController < ApplicationController
  def update
    program_path = params[:id]
    program_name = File.basename(program_path)
    program = configuration.program_by_name(program_name)
    raise ActionController::RoutingError.new('Not Found') if program.nil?
    configuration.switch_program(program)
    render nothing: true
  end
end
