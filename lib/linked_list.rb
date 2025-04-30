require_relative "node"

class LinkedList # rubocop:disable Style/Documentation
  attr_accessor :head, :size, :tail

  def initialize
    @head = nil
    @size = 0
    @tail = nil
  end

  def prepend(key, value)
    @head = Node.new(key, value, @head)
    @size += 1
    self
  end

  def append(key, value)
    if @head.nil?
      prepend(key, value)
      @tail = @head
    else
      @tail.next_node = Node.new(key, value, nil)
      @tail = @tail.next_node
      @size += 1
    end
  end

  class Node # rubocop:disable Style/Documentation
    attr_accessor :key, :value, :next_node

    def initialize(key, value, next_node)
      @key = key
      @value = value
      @next_node = next_node
    end
  end
  private_constant :Node
end
