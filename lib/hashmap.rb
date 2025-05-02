require_relative "node"
require_relative "linked_list"

class HashMap # rubocop:disable Style/Documentation
  attr_accessor :buckets

  def initialize
    @load_factor = 0.8
    @buckets = Array.new(16, nil)
    @capacity = @buckets.size
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def validate_index(key)
    handle_buckets_growth

    index = (hash(key) % capacity)

    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def handle_buckets_growth
    limit = (@capacity * @load_factor).floor
    entries = length

    return unless entries > limit

    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity, nil)

    old_buckets.each do |bucket|
      next if bucket.nil?

      bucket.each do |node|
        set(node.key, node.value)
      end
    end
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

  def length
    size = 0
    @buckets.each do |bucket|
      next if bucket.nil?

      size += bucket.size
    end
    size
  end

  def clear
    @buckets = Array.new(16, nil)
    @capacity = 16
  end

  def keys
    keys_arr = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each do |node|
        keys_arr << node.key
      end
    end
    keys_arr
  end

  def values
    values_arr = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each do |node|
        values_arr << node.value
      end
    end
    values_arr
  end

  def entries
    entries_arr = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each do |node|
        entries_arr << [node.key, node.value]
      end
    end
    entries_arr
  end
end
