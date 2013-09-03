require "treetop"
require "pry"

class Treetop::Runtime::SyntaxNode
  def accept(visitor)

  end
end

module AmbiConfig
  class ComponentNode < Treetop::Runtime::SyntaxNode
    def accept(visitor)
      component = Component.new name.value
      process_properties(component)
      visitor.add_component(component)
    end

    def process_properties(component)
      properties_visitor = PropertyVisitor.new component
      properties.elements.each do |property|
        property.accept(properties_visitor)
      end
    end
  end

  class ProgramNode < Treetop::Runtime::SyntaxNode
    def accept(visitor)
      program = Program.new visitor.next_program_id, name.value
      process_activations(program)
      visitor.add_program(program)
    end

    def process_activations(program)
      activation_visitor = ActivationVisitor.new program
      activations.elements.each do |activation|
        activation.accept(activation_visitor)
      end
    end
  end

  class PropertyNode < Treetop::Runtime::SyntaxNode
    def accept(visitor)
      visitor.add_property(property_name.value, property_value.value)
    end
  end

  class ActivationNode < Treetop::Runtime::SyntaxNode
    def accept(visitor)
      visitor.add_activation(name.value)
    end
  end
end

class ActivationVisitor
  def initialize(program)
    @program = program
  end

  def add_activation(name)
    @program.add_activation(name)
  end
end

class PropertyVisitor
  def initialize(program)
    @program = program
  end

  def add_property(name, value)
    @program.add_property(name, value)
  end
end

class ConfigVisitor
  attr_reader :programs, :components, :next_program_id

  def initialize()
    @programs = []
    @components = []

    @next_program_id = 0
  end

  def add_component(component_node)
    @components << component_node
  end

  def add_program(program_node)
    @programs << program_node
    @next_program_id += 1
  end
end

class AmbiConfigProcessor
  attr_reader :programs, :components

  def initialize(programs, components)
    @programs = programs
    @components = components
  end

  def self.parse(filename)
    parser_class = Treetop.load("app/services/ambiconfig.treetop")
    parser = parser_class.new
    ast = parser.parse(File.read filename)

    visitor = ConfigVisitor.new
    ast.elements.each do |element|
      element.accept(visitor)
    end

    AmbiConfigProcessor.new(visitor.programs, visitor.components)
  end
end

#require "ambiconfigprocessor"; AmbiConfigProcessor.new "/Users/cschwartz/ambi-tv.conf"
