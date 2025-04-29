class Node # rubocop:disable Style/Documentation
  attr_accessor :key, :value, :next_node

  def initialize(key, value, next_node)
    @key = key
    @value = value
    @next_node = next_node
  end
end
