require_relative "lib/hashmap"
require_relative "lib/linked_list"

new_hash_map = HashMap.new

new_hash_map.set("Rama", "i am the old value")
new_hash_map.set("Sita", "i am the new value")
p new_hash_map.get("Sita")
p new_hash_map.has?("jade")
p new_hash_map.remove("Rama")
p new_hash_map.has?("Rama")
p new_hash_map.length
p new_hash_map.keys
p new_hash_map.values
p new_hash_map.entries
