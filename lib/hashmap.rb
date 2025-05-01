require_relative "node"
require_relative "linked_list"

class HashMap # rubocop:disable Style/Documentation
  attr_accessor :buckets

  def initialize
    @load_factor = nil
    @capacity = nil
    @buckets = Array.new(16, nil)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def validate_index(key)
    index = (hash(key) % 16)

    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def set(key, value)
    index = validate_index(key)

    # if the bucket is empty, create a new linked list and occupy the vacant bucket
    if @buckets[index].nil?
      list = LinkedList.new
      @buckets[index] = list.prepend(key, value)

    # if the key already exits in the list, update the value with the new one
    elsif @buckets[index].contains?(key)
      @buckets[index].update_value(key, value)

    # otherwise append the new key value pair
    else
      @buckets[index].append(key, value)
    end
  end

  def get(key)
    index = validate_index(key)

    # returns the value if key is found in the linked list (@buckets[index]), otherwise return nil
    return @buckets[index].get_value(key) if @buckets[index].contains?(key)

    nil
  end

  def has?(key)
    index = validate_index(key)

    return false if @buckets[index].nil?

    @buckets[index].contains?(key)
  end

  def remove(key)
    index = validate_index(key)

    return nil if @buckets[index].nil? || !@buckets[index].contains?(key)

    @buckets[index].delete(key)
  end
end
