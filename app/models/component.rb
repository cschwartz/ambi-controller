
class Component
  include ActiveModel::Model

  attr_reader :name, :properties

  def initialize(component_name)
    @properties = {}
    @name = component_name
  end

  def add_property(name, value)
    @properties[name] = value
  end
end


