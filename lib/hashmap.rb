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

  def set(key, value)
    bucket_location = (hash(key) % 16) # calculates the bucket number

    if @buckets[bucket_location].nil? # check if the bucket is empty
      list = LinkedList.new
      @buckets[bucket_location] = list.prepend(key, value)
    end
  end
end

a = HashMap.new
a.set("jade", "bugnos")
