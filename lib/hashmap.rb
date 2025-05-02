require_relative "linked_list"

class HashMap # rubocop:disable Style/Documentation
  attr_accessor :load_factor, :buckets, :capacity

  def initialize
    @load_factor = 0.75
    @buckets = Array.new(16, nil)
    @capacity = @buckets.size
  end

  # this method converts input key into a hash code
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  # this method will throw an error if index is out of bounds
  def validate_index(key)
    handle_buckets_growth

    index = (hash(key) % @capacity)

    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  # this method automatically resizes the buckets if the limit capacity is passed
  def handle_buckets_growth
    limit = (@capacity * @load_factor).floor
    entries = length

    return unless entries > limit

    # creates a new bucket with doubled size, then rehashes all the entries from old bucket to the new
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

  # this method adds a key value pair to the hashmap/buckets
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

  # returns the value if key is found in the linked list (@buckets[index]), otherwise return nil
  def get(key)
    index = validate_index(key)

    return @buckets[index].get_value(key) if @buckets[index].contains?(key)

    nil
  end

  # returns true if key is found in the hash otherwise false
  def has?(key)
    index = validate_index(key)

    return false if @buckets[index].nil?

    @buckets[index].contains?(key)
  end

  # deletes a key from the hash map if key is found then returns it. otherwise returns nil
  def remove(key)
    index = validate_index(key)

    return nil if @buckets[index].nil? || !@buckets[index].contains?(key)

    @buckets[index].delete(key)
  end

  # returns the number of stored keys in the hash map
  def length
    size = 0
    @buckets.each do |bucket|
      next if bucket.nil?

      size += bucket.size
    end
    size
  end

  # removes all entries in the hash map
  def clear
    @buckets = Array.new(16, nil)
    @capacity = 16
  end

  # maps the hash map then stores the data in an array then returns it
  def traverse_collect
    entries_arr = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each do |node|
        entries_arr << yield(node)
      end
    end
    entries_arr
  end

  # returns all the keys in the hash map inside an array
  def keys
    traverse_collect(&:key)
  end

  # returns all the values in the hash map inside an array
  def values
    traverse_collect(&:value)
  end

  # returns all key value pairs in the hash map inside an array
  def entries
    traverse_collect { |node| [node.key, node.value] }
  end

  def to_s
    entries.each do |item|
      puts "#{item[0]} => #{item[-1]}"
    end
  end
end
