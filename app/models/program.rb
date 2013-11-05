class Program
  include ActiveModel::Model

  attr_reader :id
  attr_reader :name
  attr_reader :activations
  attr_accessor :isCurrent

  def initialize(id, program_name)
    @id = id
    @name = program_name
    @activations = []
  end

  def add_activation(activation)
    @activations << activation
  end
end
