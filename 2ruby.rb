#Hashes
hash1 = {:fruit => "apple", :veggetable => "tomato", :number => 7}
hash2 = {fruit: "apple", vegetable: "tomato", number: 7}

#Arrays
arr = hash1.sort_by {|key,value| key} #[[:fruit, "apple"], [:number, 7], [:veggetable, "tomato"]]
arr1 = hash1.sort_by(&:itself) #[[:fruit, "apple"], [:number, 7], [:veggetable, "tomato"]]
p arr1

arr.each {|key| p "key: #{key}"}
#"key: [:fruit, \"apple\"]"
# "key: [:number, 7]"
# "key: [:veggetable, \"tomato\"]"

arr.each {|key, value| p "key: #{value}"}
# "key: apple"
# "key: 7"
# "key: tomato"

arr.each {|key,value| p "key: #{key}, value: #{value}"}
# "key: apple"
# "key: 7"
# "key: tomato"