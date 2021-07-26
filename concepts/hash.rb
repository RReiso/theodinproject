h = Hash[[[1,2],[3,4],[5,6],[6,7]]]
p h # {1=>2, 3=>4, 5=>6, 6=>7}
h = Hash([]) # empty hash

h = {a: 1, b: 2, c:3}
p h["d"] # nil
# h.fetch["d"] # ArgumentError
# h.fetch("d") # KeyError
p h.fetch("d", 4) # 4
p h.fetch(:a, 7) # 1
p h.values_at(:a,:d) # [1,nil]
# h.fetch_values(:a,:d) #KeyError

# .dig - for nested arrays

h = Hash.new(0)
p h[:a] # 0
p h # {}

h = Hash.new{|hash,key| hash[key] = 0}
p h[:a] # 0
p h # {:a=>0}

p h.update({a: 1, b:2}) # {:a=>1, :b=>2}
p h.replace({c:3}) # {:c=>3}

p h.has_key?(:c) #true
p h.include?(:c)
p h.key?(:c)
p h.member?(:c)
p h.has_value?(3) # true
p h.value?(3)
p h.empty? # false
p h.size # 1

# select, reject - with block
# compact - eliminates keys with value nil
# clear - empties the hash
