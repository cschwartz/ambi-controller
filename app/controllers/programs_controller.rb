class ProgramsController < ApplicationController
  def index
    @programs = configuration.programs
  end

  def show
    program_name = params[:id]
    @program = configuration.program_by_name(program_name)
    raise ActionController::RoutingError.new('Not Found') if @program.nil?
  end
end
