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
    @tail = @head
    @size += 1

    # we return self here (linked list object) so it can be stored in the array
    self
  end

  def append(key, value)
    @tail.next_node = Node.new(key, value, nil)
    @tail = @tail.next_node
    @size += 1
  end

  def contains?(key)
    tmp = @head
    until tmp.nil?
      return true if key == tmp.key

      tmp = tmp.next_node
    end
    false
  end

  def update_value(key, value)
    tmp = @head

    until tmp.nil?
      break if key == tmp.key

      tmp = tmp.next_node
    end

    tmp.value = value
  end

  def get_value(key)
    tmp = @head

    until tmp.nil?
      return tmp.value if key == tmp.key

      tmp = tmp.next_node
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
