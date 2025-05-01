require_relative "node"

class LinkedList # rubocop:disable Style/Documentation
  attr_accessor :head, :size, :tail

  def initialize
    @head = nil
    @size = 0
    @tail = nil
  end

  def prepend(key, value)
    @head = Node.new(key, value, nil, nil)
    @tail = @head
    @size += 1

    # we return self here (linked list object) so it can be stored in the array
    self
  end

  def append(key, value)
    @tail.next_node = Node.new(key, value, nil, @tail)
    @tail = @tail.next_node
    @size += 1
  end

  def contains?(key)
    current_node = @head
    until current_node.nil?
      return true if key == current_node.key

      current_node = current_node.next_node
    end
    false
  end

  def update_value(key, value)
    current_node = @head

    until current_node.nil?
      break if key == current_node.key

      current_node = current_node.next_node
    end

    current_node.value = value
  end

  def get_value(key)
    current_node = @head

    until current_node.nil?
      return current_node.value if key == current_node.key

      current_node = current_node.next_node
    end
  end

  def delete(key) # rubocop:disable Metrics/AbcSize
    current_node = @head

    # traverse the list until the last node or if the key is found
    current_node = current_node.next_node until current_node.nil? || current_node.key == key

    return if current_node.nil? # exit early if the key not found

    value = current_node.value

    # if there is a previous node, bypass the current node. otherwise update the next node to be the new head
    if current_node.prev_node
      current_node.prev_node.next_node = current_node.next_node
    else
      @head = current_node.next_node
    end

    # if there is a next node, bypass the current node. otherwise update the prev node to be the new tail
    if current_node.next_node
      current_node.next_node.prev_node = current_node.prev_node
    else
      @tail = current_node.prev_node
    end

    @size -= 1
    value
  end

  def each
    current_node = @head

    until current_node.nil?
      yield(current_node)

      current_node = current_node.next_node
    end
  end

  class Node # rubocop:disable Style/Documentation
    attr_accessor :key, :value, :next_node, :prev_node

    def initialize(key, value, next_node, prev_node)
      @key = key
      @value = value
      @next_node = next_node
      @prev_node = prev_node
    end
  end
  private_constant :Node
end
