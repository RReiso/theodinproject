#Nested classes and modules. Scope (1.5)
class C
  a = 5
  module M
    a = 4
    module N
      a = 3
      class D
        a = 2
        def show_a
          a = 1
          puts a
        end
        puts a
      end
      puts a
    end
    puts a
  end
  puts a
end
d = C::M::N::D.new
d.show_a
 #Output: 23451

 #Accessibility of constants:
module M
  class C
    X = 2
    class D
      module N
        X = 1
      end
    end
  end
end
puts M::C::D::N::X
puts M::C::X
#Output: 1,2

class Painting
  @@styles = []
  @@paintings = {}
  @@total_count = 0
  attr_reader :style
  
  def self.all_paintings
    @@paintings
  end
  def self.total_count
    @@total_count
  end
  def self.add_style_to_library(style)
    if !@@styles.include?(style)
      @@styles << style
      @@paintings[style] = 0
    end
  end

  def initialize(style)
    if @@styles.include?(style)
      puts "Drawing a new painting in #{style} style!"
      @style = style
      @@paintings[style] += 1
      @@total_count += 1
    else
      raise "No such style in the library: #{style}."
    end
  end
  def same_style_count
    @@paintings[self.style]
  end
end
Painting.add_style_to_library("Impressionism")
Painting.add_style_to_library("Cubism")
paint1 = Painting.new("Impressionism")
paint2 = Painting.new("Cubism")
paint3 = Painting.new("Impressionism")
puts "There are #{paint1.same_style_count} paintings in #{paint1.style} style."
puts "There are #{Painting.total_count} paintings total."
puts Painting.all_paintings
# Drawing a new painting in Impressionism style!
# Drawing a new painting in Cubism style!
# Drawing a new painting in Impressionism style!
# There are 2 paintings in Impressionism style.
# There are 3 paintings total.
# {"Impressionism"=>2, "Cubism"=>1}

# @variable and self.method in class definition
class Person
    attr_accessor :name
    def initialize(name)
        @name = name
    end
    def greet
        puts "Hello #{@name}"      
        puts  "Hello #{self.name}" #Calling method name on self (def name @name end) - from attr_acc.
        puts "Hello #{name}" #Calling a name methof that returns @name
    end
end

p1 = Person.new("John")
p1.greet


#Exceptions
def fussy_method(x)
  raise ArgumentError, "I need a number under 10" unless x < 10 #instances of exception classes are raised (ArgumentError.new)
end

begin
  fussy_method(20)
rescue ArgumentError => e #assign the exception object to variable "e"
  puts "That was not an acceptable number!"
  puts "Here's the backtrace for this exception:"
  puts e.backtrace
  puts "And here's the exception object's message:"
  puts e.message
end

# The splat * operator
a = ["a","b"]
def join(x,y)
  puts x + " " + y
end
join(*a) #a b
#join(a) #ArgumentError

#Symbol example
sym = :david
puts sym.upcase #DAVID
puts sym.succ #davie
puts sym[2]# "v"

#Keyword arguments
def m(a:, b:)
  puts a,b
end
m(a:1,b:2)
#m(3,5) # required keywords: a, b (ArgumentError)

#Range inclusion
r = "a".."z"
puts r.cover?("abc")#true
puts r.cover?("yzzzzzzz")#true
puts r.cover?("zab")#false
puts r.cover?("aBc")#true
n = 1.0..2.0
puts n.include?(1.567886)#true
puts n.include?(3.567886)#false

#Sets
require "set"
a = Set.new(["B", "C"])
puts a.object_id
a.add("E")
puts a
puts a.object_id
a.add({ "A" => "a", "B" => "b" })
puts a
a.merge({ "C" => "c", "D" => "d" })
puts a
puts a.object_id
b = Set.new({ "C" => "c", "D" => "d" })
puts b

#generate numbers with step 3 from 10 to 25
k=[]
10.step(25,3).each {|el| k<<el}
puts k

# Regex example
string = "My phone number is (123) 555-1234."
phone_re = %r{\((\d{3})\)\s+(\d{3})-(\d{4})}
m = phone_re.match(string)
3.times do |index|
 puts "Capture ##{index + 1}: #{m.captures[index]}"
end

#Find word length with reduce method
def find_word_lengths(word_list)
  word_list.reduce(Hash.new(0)) do |hash, el|
    hash[el] += el.size
    hash
  end
end
p(find_word_lengths(%w(hi there how is everyone)))

#Find word length with each method
def word_length(list)
  hash={}
  list.each {|w| hash[w] = w.size}
  hash
end
p(word_length(%w(hi there how is everyone)))

#Lambda and proc example
def lambda_vs_proc
 my_lam = lambda {return puts "Hi, I'm your lambda!"  }
 my_lam.call
 puts "Returned from lambda!"
 my_proc = Proc.new { return puts "Hello from proc!" }
 my_proc.call
 puts "The proc will not allow this to be seen!"
end
 lambda_vs_proc
# Hi, I'm your lambda!
# Returned from lambda!
# Hello from proc!

module Masr
 def self.extended(obj)
    def obj.acce
      puts "hello"
    end
 end
 def an_inst_method
 puts "This module supplies this instance method."
 end
end
my_object = Class.new
my_object.extend(Masr)
my_object.an_inst_method
my_object.acce

#class instance variable
class Cow
@count = 10
def self.count
@count
end
end
class BigCow < Cow
end
p Cow.count # 10
p BigCow.count #nil

class BigCow
  @count=200
end
p BigCow.count #200

value = [1, 2, 3]
p value_at_index_four: value[4], all_values: value
#{:value_at_index_four=>nil, :all_values=>[1, 2, 3]}