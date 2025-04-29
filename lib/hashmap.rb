require_relative "node"

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

  def set(key, value)
    bucket_location = (hash(key) % 16) - 1 # calculates the bucket number
    new_node = Node.new(key, value, nil)

    if @buckets[bucket_location].nil? # check if the bucket is empty
      @buckets[bucket_location] = new_node
      p @buckets
    elsif 

    end
  end
end

a = HashMap.new
a.set("jade", "bugnos")
