class ComponentsController < ApplicationController
  def index
    @components = configuration.components
  end

  def show
    component_name = params[:id]
    @component = configuration.component_by_name(component_name)
    raise ActionController::RoutingError.new('Not Found') if @component.nil?
  end
end
