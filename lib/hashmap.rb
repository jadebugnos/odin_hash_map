require_relative "node"
require_relative "linked_list"

class HashMap
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
    index = (hash(key) % 16) # calculates the bucket's index

    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def set(key, value)
    index = validate_index(key)

    if @buckets[index].nil? # check if the bucket is empty
      list = LinkedList.new
      @buckets[index] = list.prepend(key, value)
    elsif @buckets[index].contains?(key)
      @buckets[index].update_value(key, value)
    else
      @buckets[index].append(key, value)
    end
  end
end
