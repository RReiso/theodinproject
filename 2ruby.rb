#Hashes
hash1 = { fruit: 'apple', veggetable: 'tomato', number: 7 }

#Arrays
arr = hash1.sort_by { |key, value| key } #[[:fruit, "apple"], [:number, 7], [:veggetable, "tomato"]]
arr = hash1.sort_by { |key| key } #[[:fruit, "apple"], [:number, 7], [:veggetable, "tomato"]]
arr1 = hash1.sort_by(&:itself) #[[:fruit, "apple"], [:number, 7], [:veggetable, "tomato"]]
p arr1

arr.each { |key| p "key: #{key}" }
#"key: [:fruit, \"apple\"]"
# "key: [:number, 7]"
# "key: [:veggetable, \"tomato\"]"

arr.each { |key, value| p "key: #{value}" }
# "key: apple"
# "key: 7"
# "key: tomato"

arr.each { |key, value| p "key: #{key}, value: #{value}" }
# "key: apple"
# "key: 7"
# "key: tomato"

#Block
def greet
  ran_nr = rand(100)
  yield ran_nr
end

greet { |nr| puts "Hello #{nr}" }

greet { |nr| puts "Welcome #{nr}!" }

def greet2(&my_block)
  ran_nr = rand(100)
  my_block.call(ran_nr)
end

greet2 { |nr| puts "Hello #{nr} with call method!" }

def greet3
  puts 'Check'
  ran_nr = rand(100)
  yield self, ran_nr if block_given?
end

greet3 { |obj, nr| puts "Hello #{obj} and #{nr} with 'if block_given'" }

greet3

#Classes
class Dessert
end

class Icecream < Dessert
  @all_icecreams = {}
  @counter = 0

  def self.counter=(num)
    @counter = num
  end

  def self.counter
    @counter
  end

  def self.all
    @all_icecreams
  end

  def initialize
    self.class.counter += 1
    @number = self.class.counter
  end

  def flavour=(flavour)
    @flavour = flavour
    self.class.all[@number] = flavour
  end

  def flavour
    @flavour
  end
end

icecream1 = Icecream.new
p icecream1.flavour #nil
icecream1.flavour = 'strawberry'
p icecream1.flavour #strawberry

#Version1:
class Icecream
  def new_flavour=(flavour)
    self.flavour = flavour #call method flavour=
  end
end
icecream1.new_flavour = 'chocolate'
p icecream1.flavour #chocolate

# Version2:
class Icecream
  def new_flavour=(flavour)
    @flavour = flavour
    self.class.all[@number] = flavour #need to explicitly append to array
  end
end
icecream1.new_flavour = 'chocolate'
p icecream1.flavour #chocolate

p Icecream.all

icecream2 = Icecream.new
icecream2.flavour = 'vanilla'

p Icecream.all

icecream1.new_flavour = 'blueberry'

p Icecream.all # {1=>"blueberry", 2=>"vanilla"}

p icecream1.kind_of?(Dessert) #true
p icecream2.instance_of?(Dessert) #false

#Class expressions
res = class Result
        "string a"
        123
end
p res #123

#validates method
class Book
  attr_accessor :title, :author, :year
  
  def self.validations
    @validations
  end
  
  def self.validates(attribute, rules)
    @validations ||=Hash.new
    @validations[attribute] = rules
  end

  validates :title, blank: false 
  validates :year, type: :int, blank: false
  
end

p Book.validations # {:title=>{:blank=>false}, :year=>{:type=>:int, :blank=>false}}

names_with_ages =
[
["lucy", 3],
["rita", 9],
["markus", 11]
]

names_with_ages.each do |name, age|
puts name.ljust(7,"*") + age.to_s
end
# lucy***3
# rita***9
# markus*11

p "1 esmu26 5".gsub(/\d+/) { |num| num.next } #"2 esmu27 6"
p "1 esmu26 5".gsub(/\d+/) (&:next) #"2 esmu27 6"
