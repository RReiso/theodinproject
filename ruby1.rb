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